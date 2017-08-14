Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E8520899
	for <e@80x24.org>; Mon, 14 Aug 2017 13:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbdHNNUi convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 14 Aug 2017 09:20:38 -0400
Received: from mx0b-00105401.pphosted.com ([67.231.152.184]:56085 "EHLO
        mx0b-00105401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752253AbdHNNUh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Aug 2017 09:20:37 -0400
Received: from pps.filterd (m0074334.ppops.net [127.0.0.1])
        by m0074334.ppops.net (8.16.0.21/8.16.0.21) with SMTP id v7EDKECO037377;
        Mon, 14 Aug 2017 09:20:34 -0400
Received: from xnwpv32.utc.com ([167.17.239.12])
        by m0074334.ppops.net with ESMTP id 2cbap6a7jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2017 09:20:34 -0400
Received: from pps.filterd (xnwpv32.utc.com [127.0.0.1])
        by xnwpv32.utc.com (8.15.0.59/8.15.0.59) with SMTP id v7EDAgw5028437;
        Mon, 14 Aug 2017 09:20:33 -0400
Received: from uusnwa4u.utc.com (uusnwa4u.utc.com [159.82.101.254])
        by xnwpv32.utc.com with ESMTP id 2cbch3r4r3-1
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2017 09:20:33 -0400
Received: from UUSALE0P.utcmail.com (UUSALE0P.utcmail.com [10.220.35.34])
        by uusnwa4u.utc.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v7EDKVn2023857
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2017 09:20:32 -0400
Received: from UUSALE0M.utcmail.com (10.220.35.32) by UUSALE0P.utcmail.com
 (10.220.35.34) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Mon, 14 Aug
 2017 09:20:31 -0400
Received: from UUSALE0M.utcmail.com ([10.220.35.32]) by UUSALE0M.utcmail.com
 ([10.220.35.32]) with mapi id 15.00.1263.000; Mon, 14 Aug 2017 09:20:31 -0400
From:   "Burkhardt, Glenn B        UTAS" <Glenn.Burkhardt@utas.utc.com>
To:     =?iso-8859-1?Q?Ux=EDo_Prego?= <uprego@madiva.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [External] Re: gitk -m ?
Thread-Topic: [External] Re: gitk -m ?
Thread-Index: AdMMfuPtWkaB7cx3TfmXS1g/Ao0BcwIXnU4AAAgsbxA=
Date:   Mon, 14 Aug 2017 13:20:31 +0000
Message-ID: <605cecc7f196495fa3d25113f28915e0@UUSALE0M.utcmail.com>
References: <6ef11677ca184e78a545452ffffe55a1@UUSALE0M.utcmail.com>
 <7F03EAEF-DFDA-4CD0-86A1-A06C775A895B@madiva.com>
In-Reply-To: <7F03EAEF-DFDA-4CD0-86A1-A06C775A895B@madiva.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-version: 3.5.15.2
x-tituslabs-classificationhash-30: VgNFIFU9Hx+/nZJb9Kg7IjMlMi8h89VCWKDzkBE7Ya2KD7Y6lQ/WIAxaTs8E6hU/BkiIy4U1JUwVOsB72QRUIU/1pLVt2/8wZMGFG7Pmp5tyz3cnbrL/FBF0cMH0Q1YzoysBYF2uH37MP8oTq6MU0qQOWZYDX9pC3Z/EWqh3WE/C6PqQkPc7kGHX7VYRizlB
x-tituslabs-classifications-30: TLPropertyRoot=UTC;TechnicalData=No;
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.220.3.240]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1706020000
 definitions=main-1708140219
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They don't.  In particular, information about commits that are parts of merges is missing.

Here's an example.  There are only two entries listed in 'gitk --all' for a particular file (sorry, I'd prefer to include a screen sho, but the mailing list doesn't allow HTML messages).

gitk --all MANIFEST.MF

Parent: f7462684ae78720aac05c929256d770118cf01fa (initial clone from Clearcase integ3 branch)
Branches: master, remotes/origin/master, remotes/origin/ww, ww
Follows: 
Precedes: 

    require java 1.8

Child:  240f151d61fd4fd06f377bc52970b3574e5f9031 (require java 1.8)
Branches: master, remotes/origin/master, remotes/origin/ww, ww
Follows: 
Precedes: 

    initial clone from Clearcase integ3 branch


git log with '-m' and '-follow' shows:

$ git log -m --follow --oneline MANIFEST.MF
9cc8be4 (from 1222d7c) Merge branch 'master' into ww; strategy "ours"
a423f2d (from f869950) merge from ww branch; remove Bundle-NativeCode
51f0628 (from 2c6478c) Merge branch 'ww' of coverity:rmps into ww
240f151 require java 1.8
f746268 initial clone from Clearcase integ3 branch


-----Original Message-----
From: Uxío Prego [mailto:uprego@madiva.com] 
Sent: Monday, August 14, 2017 01:12
To: Burkhardt, Glenn B UTAS
Cc: git@vger.kernel.org
Subject: [External] Re: gitk -m ?

Not sure what you are wanting to achieve, but please make sure neither `gitk PATHSPEC` nor `gitk --all PATHSPEC` are presenting you enough information.

> On 3 Aug 2017, at 19:37, Burkhardt, Glenn B UTAS <Glenn.Burkhardt@utas.utc.com> wrote:
> 
> I've been looking in 'gitk' for an option that does what 'git log -m' does.  Did I miss something?  In particular, I'd like to get information about a file that's currently available with "git log -m --all --follow", but presented in 'gitk'.  If it's not there, please consider this a feature request.
> 
> Thanks.

