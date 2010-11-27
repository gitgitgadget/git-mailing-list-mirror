From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: Patchbombing or not, that is the question
Date: Sat, 27 Nov 2010 15:40:29 -0200
Message-ID: <AANLkTimKdwrsYQHGL=KaoQEmv3FLJzS+M=5xdQi+A5Ny@mail.gmail.com>
References: <AANLkTi=C4opog2SfU9R_=dSOGY_5+0WYtFL8BNqcOwUw@mail.gmail.com>
	<20101127172757.GA1858@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 18:40:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMOlJ-0004Fi-2o
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 18:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab0K0Rkb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 12:40:31 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60905 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab0K0Rkb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Nov 2010 12:40:31 -0500
Received: by bwz15 with SMTP id 15so2701397bwz.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 09:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ooV2PUXV0cGHsWj9LefaErZmWG9wXuj7mB3LbvqpZnA=;
        b=Q/zJ1sPCOPNGMOgs8MTY04f8nUCAyFqUIp1x/l2plFRbjmi3wRQ6znjQaUOtZyt+R5
         sSkM6W2eITxKQu+AczOoAktFx1Y+qP/6aWHwverpcY8M254WFyjYyheQn3diSw/4EoVb
         UnffmTC7gzWEIaScBigLx3KP99gGTxisXoql8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lobXWIQestiHicgx/Uylh9iH97UCKRCNTfVt4aul1VQ4c8HQgelTceZ5gczzEEFLIt
         NHgI4VHy8HJxKfXuhOUhtns2LV9HadKMCITLkNSyIYtun/TFsfptoSiuoWRM/A+MewrL
         ttB7uYDxn65+9evbRIdOGVCUCFrkNq4hyN9t8=
Received: by 10.204.60.66 with SMTP id o2mr1145455bkh.13.1290879629376; Sat,
 27 Nov 2010 09:40:29 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Sat, 27 Nov 2010 09:40:29 -0800 (PST)
In-Reply-To: <20101127172757.GA1858@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162318>

On Sat, Nov 27, 2010 at 3:27 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Giuseppe Bilotta wrote:
>
>> I prepared a bunch of patches to add support to some other browsers =
to
>> git-web--browse (opera, seamonkey, elinks). Currently I did one patc=
h
>> per browser. Should I squash them all together?
>
> Yeah, I'd squash them. =C2=A0(But I think either way would be fine.)
>
> Could you support
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[browser "chromium-browser"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd=3Dchromium=
-browser
>
Yeah, that would be great!
