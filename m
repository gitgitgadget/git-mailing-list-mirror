From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Challenges for an octopus merge
Date: Sat, 12 Feb 2011 05:50:16 +0100
Message-ID: <4D561188.4000109@web.de>
References: <4D53F694.1060105@web.de> <7v8vxn6fdv.fsf@alter.siamese.dyndns.org> <4D55627F.30305@web.de> <7vd3my1leq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 05:51:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po7Rv-0008NN-Al
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 05:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758238Ab1BLEuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 23:50:55 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:48063 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756892Ab1BLEuz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 23:50:55 -0500
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 95FA219724C62;
	Sat, 12 Feb 2011 05:50:28 +0100 (CET)
Received: from [92.228.198.199] (helo=[192.168.1.46])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Po7RE-0001Tg-00; Sat, 12 Feb 2011 05:50:28 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.13) Gecko/20101206 SUSE/3.1.7 Thunderbird/3.1.7
In-Reply-To: <7vd3my1leq.fsf@alter.siamese.dyndns.org>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+lAPAVd2fCIUuePGTmzbaGL6S3x5fN2plPEEnV
	M1zpOLo6KWo1x/rHQ8WKUy3npebZA/EwzR2rmgW6a36ieVzDpK
	cGcPh99Csf2L14jefysA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166592>

> The user needs to decide what to do next; the user may choose to do "git merge A C ; git merge B" instead,
> but *after* inspecting the situation.

I have inspected my situation a bit more. I hope that the merging process can be 
improved so that it can cope with my update suggestions here.

Would anybody (besides me) like to look into the affected patches and source 
files if the tool "Git" can provide a better service?

Does it make sense to add these files to your test-suite?

Regards,
Markus
