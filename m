From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (May 2011, #01; Sun, 1)
Date: Tue, 03 May 2011 08:43:20 +0200
Message-ID: <4DBFA408.4080408@viscovery.net>
References: <7vd3k2q8lt.fsf@alter.siamese.dyndns.org> <BANLkTikFK9k=7hGB8AJ4mz88sff=roXd5g@mail.gmail.com> <7vsjswk9mf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 08:43:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH9KR-0002Jc-3l
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 08:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab1ECGnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 02:43:22 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62809 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752386Ab1ECGnV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 02:43:21 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QH9KK-0007tv-RH; Tue, 03 May 2011 08:43:20 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9C6BD1660F;
	Tue,  3 May 2011 08:43:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vsjswk9mf.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172648>

Am 5/3/2011 0:42, schrieb Junio C Hamano:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
> 
>> On Mon, May 2, 2011 at 1:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> * kk/maint-prefix-in-config-mak (2011-04-28) 1 commit
>>>  - Honor $(prefix) set in config.mak* when defining ETC_GIT* and sysconfdir
>>>
>>> Wait for msysgit folks to Ack, and then merge to "next".
>>
>> This patch works fine for me in msysGit.
> 
> Thanks.

Sorry for being late, but I have to object. See my reply to the patch
submission.

-- Hannes
