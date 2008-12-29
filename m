From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: "git-whatever" the new style vs. "git whatever"?
Date: Mon, 29 Dec 2008 16:27:09 -0500
Message-ID: <495940AD.2070602@gmail.com>
References: <7vfxk7cnmw.fsf@gitster.siamese.dyndns.org> <87sko6lqmo.fsf_-_@jidanni.org> <200812291447.01713.bss@iguanasuicide.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Mon Dec 29 22:29:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHPfG-0003hd-Kw
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 22:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbYL2V1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 16:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752930AbYL2V1Q
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 16:27:16 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:62739 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbYL2V1P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 16:27:15 -0500
Received: by an-out-0708.google.com with SMTP id d40so1551114and.1
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 13:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nLBMbgYZjcGBVrSTdEBy9dmAB7VzKXBkCRIhvP0GonM=;
        b=RlXWv5b7064TVLAcfp0ILrzD1y2Hfwj/ce9/9VOzuQOl9srfQYQvBjreZFGeCCtqf5
         fvTp3cMlWmqdlxRVELj113pdDpCeHck/9FzVEdVo0vVvqBsDUiPSj2vRVaij/ikiLc5+
         dpYOGOnGQwo50ThnovPf8ZYgXvNmwZ3S4hW38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=Euibe06wTwU5TQo/qxg+2Q6clayAKfIqZpqhiSPh6j6GS1FiJXftZwGDtL/K3lcN0Y
         3hUvIj0Lx6zJlu1cy892spwvys8A2zBlsQQZ/enVbf4LBif0X3FmLOCBhtmxi4eFb/T9
         u9d1Pzu2yKVokLiJ+UKj0dMolQtup8v2MgM2k=
Received: by 10.100.136.18 with SMTP id j18mr7910621and.153.1230586033867;
        Mon, 29 Dec 2008 13:27:13 -0800 (PST)
Received: from ?192.168.1.6? (c-67-191-46-125.hsd1.fl.comcast.net [67.191.46.125])
        by mx.google.com with ESMTPS id c37sm20063444ana.57.2008.12.29.13.27.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Dec 2008 13:27:13 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <200812291447.01713.bss@iguanasuicide.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104128>

Boyd Stephen Smith Jr. wrote:
> On Monday 2008 December 29 13:37:19 jidanni@jidanni.org wrote:
>> JCH> I think he is comparing "git am" and "git-am" the latter of which is
>> JCH> now deprecated and largely removed from the end user.
>>
>> By the way, we here at the end user end have a hard time detecting if
>> "git-whatever" the new style vs. "git whatever"...
> 
> That shouldn't be a problem for much longer because "git-whatever" will stop 
> working.  From what I understand, "git whatever" has always been the 
> preferred form, and the fact that "git-whatever" worked was just a 
> implementation detail.

This is a revisionist history. Check the history of the git command to 
find out when it was created and then check the ML archives for related 
discussions.
