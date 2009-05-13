From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [msysGit] Re: The 9th production of the msysGit Herald
Date: Wed, 13 May 2009 12:18:20 +0200
Message-ID: <4A0A9E6C.4060408@gmail.com>
References: <alpine.DEB.1.00.0905130225330.27348@pacific.mpi-cbg.de> <4A0A797B.7080400@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed May 13 12:18:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4BXk-000633-5Y
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 12:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757714AbZEMKSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 06:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbZEMKSX
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 06:18:23 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:62933 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbZEMKSX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 06:18:23 -0400
Received: by ey-out-2122.google.com with SMTP id 9so170614eyd.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=80sWVZV9OqKKTOmRqjpk5ApXaRwzhBSBzlv1N2uuYeI=;
        b=XHDaOKskFblcdlFvld28pB9dtcmXiAtMuOcAZW6wYmDNRmQ4RfVX8BN1mu4vgmicxo
         FMNOJuv00d4eySFve+Kf89LlJl/pyQYbpXoiFAAhnGSBMb1MQoa/dwWMBopEHnEUgExi
         cVGq+R/uZptl9NkgGPdxoQmg77vgf1ft77iBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=oAN7fVjlztqGN8PJmRx1xi6Z4WJI9p1rkK/HkC6jkDu9hcXIAnRDcDo3agVO5tBFaa
         LHNKSkbG2+Ht49TxRiFYxFSG0PuElVMyCfoY+oWGugJ+22AQPS7TiFzzdoUNOKu8H4ba
         WJihtuR0ASuJSR6amBAeO5/nBytChyi/fest4=
Received: by 10.210.10.11 with SMTP id 11mr1968582ebj.69.1242209903095;
        Wed, 13 May 2009 03:18:23 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 5sm2261990eyf.8.2009.05.13.03.18.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 03:18:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.21) Gecko/20090302 Lightning/0.9 Thunderbird/2.0.0.21 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <4A0A797B.7080400@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119025>

Andreas Ericsson said the following on 13.05.2009 09:40:
> Johannes Schindelin wrote:
>> The "netinstall" and "fullinstall" packages should work again 
>> (fullinstall is stuck at 1.6.1 for the moment, basically because
>> I am too lazy, and do not want to waste much of our Google Code
>> quota for a new fullinstall package).
> 
> I should think we could host legacy install-packages at $dayjob if
> you need the diskspace. Let me know if you're interested and I'll
> poke our sysadmin and ask him to set something up.

According to Google they are pretty liberal with quotas, if a project 
needs it and asks them. It's just that they don't want a huge quota as 
default for all projects.

AFAIK you can just ask for an increased quota here:
     http://groups.google.com/group/google-code-hosting/

See 
http://google-code-updates.blogspot.com/2008/12/happy-holidays-from-google-code.html

--
.marius
