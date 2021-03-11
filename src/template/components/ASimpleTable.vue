<template lang="pug">
.flex-column
  // search
  //- input.p-2.border(:placeholder="$t('search')")
  // download
  .flex-row
    input.p-2.border.rounded(:placeholder="$t('search')" v-model="filter")
    .flex-1
    slot(name="right")
  // table
  table.w-full.mt-1.border.shadow.bg-white.rounded.overflow-auto
    // head
    tr
      td.border.bg-gray-800.text-white.p-3.font-semibold STT
      td.border.bg-gray-800.text-white.p-3.font-semibold(v-for="col in columns") {{col.label}}
    tr(v-for="( row, index ) in pRows")
      td.p-2.border 
        span(slot="__index") {{getIndex(index)}}
      td.p-2.border(v-for="col in columns") 
        slot(:name="'col_' +  col.field" :row="row" :col="col" :value="getCell(row, col.field, col.format, index)")
          span {{getCell(row, col.field, col.format, index)}}
  // pagination
  .flex-row.items-center.justify-end.mt-2(v-if="totalPage > 1")
    .flex-row.items-center
      button.w-10.h-10.rounded.bg-white.mr-1.border(@click="prevPage")
        i.fa.fa-angle-left
      span.text-sm.mx-1 {{currentPage}} / {{totalPage}}
      button.w-10.h-10.rounded.bg-white.mr-1.border(@click="nextPage")
        i.fa.fa-angle-right

</template>
<script lang="ls">
# add right slot
# with index and download
export default _ =
  props: ['rows', 'columns']
  data: ->
    filter: ''
    currentPage: 1
    pagination:
      rowPerPage: 10
  computed:
    totalPage: ->
      Math.ceil @rows.length / @pagination.rowPerPage
    startRow: ->
      start = @pagination.rowPerPage * (@currentPage - 1)
    fRows: ->
      unless @filter
        @rows
      else
        filter = @filter
        @rows.filter (i) -> 
          Object.values i .some (j) -> String j .toLowerCase!includes filter.toLowerCase!
    pRows: ->
      unless @fRows.length
        @fRows
      else
        start = @startRow
        end = @pagination.rowPerPage + start
        @fRows.slice start, end
  methods:
    prevPage: ->
      if @currentPage > 1
        @currentPage--
    nextPage: ->
      if @currentPage < @totalPage
        @currentPage++
    getIndex: (index) ->
      cell = index + @startRow + 1
    getCell: (row, field, format, index) ->
      cell = if typeof field == 'function' then field row else row[field]
      if typeof format == 'function' then format cell else cell
</script>
// column sample

    columns:
      * field: \shift, label: @$t \shift
      * field: \barcode, label: @$t \barcode
      * field: \deviceType, label: @$t \type
      * field: \deviceGroup, label: @$t \group
      * field: \deviceName, label: @$t \device_name
      * field: \orderName, label: @$t \order_name
      * field: \orderNumOfDevice, label: @$t \num_of_device
      * field: \orderCode, label: @$t \order_code
      * field: \orderSize, label: @$t \size
      * field: \orderTarget, label: @$t \target
      * field: \orderCycleTime, label: @$t \cycle_time

      # formula
      * field: target_per_shift, label: @$t \target_per_shift
      * field: \formula1, format: (->0), label: @$t \not_plan
      * field: \formula2, format: (->0), label: @$t \stop_plan
      * field: \formula3, exp: 'availibility', label: @$t \availibility
      * field: \formula4, exp: 'quality', label: @$t \quality
      * field: \formula5, exp: 'performance', label: @$t \performance
      * field: \formula6, exp: 'OEE', label: @$t \OEE
      * field: total_error, name: \total_liner_error, label: @$t \total_liner_error

      * field: \count, label: @$t \product_count
      * field: \status0, format: sec2min, label: @$t \run_time
      * field: \stopTime, format: sec2min, label: @$t \stop_time
      * field: (-> it.status0 + it.stopTime), format: sec2min, name: \total_time, label: @$t \total_time
      * field: (-> it.count && it.status0 / it.count), format: sec2min, label: @$t \avg_product
      * field: \error1, label: @$t \product_error_1
      * field: \_action, label: @$t \action

##########
            ASimpleTable(:rows="filteredRows" :columns="columns")
                .flex.items-center(slot="right")
                    span.mr-2 {{$t('room')}}:
                    ALayoutPicker(v-model="selectedLayoutId")
                template(slot="col__action" slot-scope="{row}")
                    .flex-row
                        AButton.mr-2(icon size="sm" @click="data = row, state = 'EDIT'")
                            i.fa.fa-edit
                        AButton(icon color="red" size="sm" @click="onDelete(row)")
                            i.fa.fa-remove
