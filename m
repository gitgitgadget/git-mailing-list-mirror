Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2445C1FE4E
	for <e@80x24.org>; Wed, 22 Jun 2016 07:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbcFVH0C (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 03:26:02 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:20374 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbcFVH0B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 03:26:01 -0400
Received: from PhilipOakley ([92.22.13.169])
	by smtp.talktalk.net with SMTP
	id FcXtbv9EryX5cFcXub8AVw; Wed, 22 Jun 2016 08:25:59 +0100
X-Originating-IP: [92.22.13.169]
X-Spam:	0
X-OAuthority: v=2.2 cv=BeKa6fl2 c=1 sm=1 tr=0 a=AyO//PYl85lkG1UGsvtC/g==:117
 a=AyO//PYl85lkG1UGsvtC/g==:17 a=8nJEP1OIZ-IA:10 a=rtvK6jT4jHOT0dCVUWMA:9
Message-ID: <0648000B273C412AB7140AE959EBC99A@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Git List" <git@vger.kernel.org>
Subject: name for A..B ranges?
Date:	Wed, 22 Jun 2016 08:25:59 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfMJAhN5YPmp8Dwrc+4MFHy3rEtaZ70efe+NcIC8jTdXJC46xvQFQpar2KdQF73TF9IypSVV7M2T4k5pzgmGcrTl9B+ESyOnk2z+2PwECagUuiBKApr0m
 horBTDl9UUjXkgGcfrrvnvLzeCrmx2iso6a8+9vb4j9FwPCKI6Jw1Cs6
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

Is there a common name for the A..B range format (two dots) that would 
complement the A...B (three dots) symmetric range format's name?

I was looking at the --left-right distinctions and noticed that the trail 
back to the symmetric range description was rather thin (it's buried within 
gitrevisions:Specifying Ranges, and even then its called a symmetric 
difference.

Philip 

