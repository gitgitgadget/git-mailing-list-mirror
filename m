From: Weiwei Shu <shuww1980@gmail.com>
Subject: Re: How to email out commit message automatically?
Date: Wed, 27 Jan 2010 11:38:52 -0500
Message-ID: <65d12cb11001270838v3b40bc85g3bf11997df98f440@mail.gmail.com>
References: <65d12cb11001270820i7094001odc4d9f27b7f57767@mail.gmail.com>
	 <vpq7hr3wln2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, shuww2008@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:39:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaAux-0003dB-TT
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 17:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166Ab0A0Qiy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2010 11:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754907Ab0A0Qiy
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 11:38:54 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:34131 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab0A0Qiy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 11:38:54 -0500
Received: by bwz19 with SMTP id 19so4861806bwz.28
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 08:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MSzg5v2sfRNS+nAlD+gyqO40lk+w0JIHOm18vb3Zp0w=;
        b=swRdlzCdUJGFx64Wa2n9LodTOJD5VmcRSnp0RHQx6u1Spr/lodviMXIdtBz9gYdUXg
         NYm/A8/0tlJOvIANlZ0Q+bXq7XCPGDOSJH8QGDj+0icxF9KPWLk5R1DcUR0zkyTvbn5l
         ei2PVEmppcAPBt1/XBQjzpneuinwPb8DTUFxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QPc3WqtpBIetmYVNGu56b17Q/KdyQ9CsQZHKlYbSOX6DwQWUeWgWVI9OpJAMksFS8u
         YiwK3pJ62kDaIHpfXKp4XgQlCL9bZtSkcUcIy3NsgtiqhwtohWdJPMqKv0/tMTHU5KpG
         4c7TyxmkWDLE+Juil677xqXTohvi2H2+Ly1Ps=
Received: by 10.204.9.134 with SMTP id l6mr4332596bkl.83.1264610332149; Wed, 
	27 Jan 2010 08:38:52 -0800 (PST)
In-Reply-To: <vpq7hr3wln2.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138169>

Matthieu,

Thank you very much!!  I'll give it a shot and hope it will work in Win=
dows.

Weiwei


On Wed, Jan 27, 2010 at 11:36 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Weiwei Shu <shuww1980@gmail.com> writes:
>
>> Hi All,
>>
>> The second time to post here. =A0Git is great.
>>
>> I would like to email the commit message to my Gmail box automatical=
ly
>> whenever I submit a commit. =A0Can anybody point me a link on how to=
 do
>> that? =A0I've searched it for half day but not successful. =A0Thanks=
!
>
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3Dcontrib/hooks/pos=
t-receive-email
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>



--=20
Weiwei
--Hope Springs Eternal.
