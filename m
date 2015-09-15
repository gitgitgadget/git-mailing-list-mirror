From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Sep 2015, #03; Mon, 14)
Date: Tue, 15 Sep 2015 20:08:42 +0100
Organization: OPDS
Message-ID: <16A99EC6028D41FFB0D36D4A1945B113@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 21:08:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbvb1-00036m-Kn
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 21:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbbIOTIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 15:08:46 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:36608 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752041AbbIOTIo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2015 15:08:44 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DVDwA2bPhVPALNYAJdGQEBgwcBgT2GWW24AYV+BASBRU0BAQEBAQEHAQEBAUEkG4QeFAEBLh4BASwCCAIBAxUMOQEEGgYHAxoBEggCAQIDAYghrg+OaY1vhnOEfYE9hm+BFAWNMYUDgygBgRqNNZVNg2yCLQwBR4FkPTOKKgEBAQ
X-IPAS-Result: A2DVDwA2bPhVPALNYAJdGQEBgwcBgT2GWW24AYV+BASBRU0BAQEBAQEHAQEBAUEkG4QeFAEBLh4BASwCCAIBAxUMOQEEGgYHAxoBEggCAQIDAYghrg+OaY1vhnOEfYE9hm+BFAWNMYUDgygBgRqNNZVNg2yCLQwBR4FkPTOKKgEBAQ
X-IronPort-AV: E=Sophos;i="5.17,536,1437433200"; 
   d="scan'208";a="559202345"
Received: from host-2-96-205-2.as13285.net (HELO PhilipOakley) ([2.96.205.2])
  by out1.ip03ir2.opaltelecom.net with SMTP; 15 Sep 2015 20:08:41 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277979>

Oops..
From: "Philip Oakley" <philipoakley@iee.org>
>> [New Topics]
>
>> * po/doc-branch-desc (2015-09-14) 1 commit
>>  (merged to 'next' on 2015-09-14 at 4934a96)
>> + doc: show usage of branch description
>>
>> The branch descriptions that are set with "git
>> branch --edit-description"
>> option were used in many places but they weren't clearly documented.
>>
>> Will merge to 'master'.
>>
> Thanks.
> Shall I just rework/resend the V2 patch-up ($gmane/277829) that also
> links to 'merge's' usage as a fresh patch (would be tonight UK)?

I now see that the full V2 patch is already there at 4934a96.
I'd mistakenly just compared your note to the slightly fuller V2 commit
message and in the morning rush hadn't had time to check.

Sorry for the noise.

Philip
