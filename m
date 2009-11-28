From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2009, #06; Wed, 25)
Date: Sat, 28 Nov 2009 01:45:25 +0100
Message-ID: <fabb9a1e0911271645i51fa3c7an6b416892a7c1592e@mail.gmail.com>
References: <7v8wduksgq.fsf@alter.siamese.dyndns.org> <fabb9a1e0911251715u661ce0aem79a4d700d552e105@mail.gmail.com> 
	<alpine.LNX.2.00.0911271417010.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Nov 28 01:46:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEBRp-00022S-1m
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 01:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbZK1Apk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 19:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbZK1Apk
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 19:45:40 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:42500 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbZK1Apk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 19:45:40 -0500
Received: by vws35 with SMTP id 35so546950vws.4
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 16:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lfua8gsPNEL2CdI83xdQYGLa5yr63fxtAiP30lWwpF4=;
        b=BiBHbBeoyv5CSgCs5S3gjXZiJST8R3dM/vA9pCNPIakhIVv8MTAlUzXZ2rF7LTOSjS
         vA9qgi1RJFx4CqztGvlMFI/eutWyFLbgDX9xr4FJIdLkfPFq4dnyKQAmFbB3JMil4GmP
         q7ShYZxjFA4T8hEC13KebQfKpGDbPZcfPE3ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dipc85lr9NmS+ORcoCppYoHFGk00s7AQCV6xe5g6nT0sJaf84Fkbl6u1xKhWuCCWL5
         aEnIqPSVrcY5VxoG7geMsMo7POAcbvAltIFjVQAxsbzlYk5DMY1FUpsPXdIQAKMSw2zT
         H2kK8mmbnen4UrAp4QulJrJhoC5ui0DfN+XH4=
Received: by 10.220.125.7 with SMTP id w7mr1966477vcr.74.1259369145049; Fri, 
	27 Nov 2009 16:45:45 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911271417010.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133943>

Heya,

On Fri, Nov 27, 2009 at 20:17, Daniel Barkalow <barkalow@iabervon.org> =
wrote:
> On Thu, 26 Nov 2009, Sverre Rabbelier wrote:
>> On Thu, Nov 26, 2009 at 02:03, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> > * sr/vcs-helper (2009-11-18) 12 commits
>> > Replaced again, and looking good. =A0Perhaps Daniel has some comme=
nts?
>>
>> Indeed, Johan, Daniel, is the current version good for next?
>
> Looks good to me.

Awesome, I'd say this is good for next then.

--=20
Cheers,

Sverre Rabbelier
