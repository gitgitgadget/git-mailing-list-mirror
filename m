From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 07:19:36 +0700
Message-ID: <AANLkTimHC3Wfqd4AbLDGuf17wEisTRutMc2VL+S=s2nM@mail.gmail.com>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110303185918.GA18503@sigill.intra.peff.net> <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
 <20110303203323.GA21102@sigill.intra.peff.net> <20110309174956.GA22683@sigill.intra.peff.net>
 <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com> <20110309215841.GC4400@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 01:20:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxTbx-0005XU-8k
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 01:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352Ab1CJAUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2011 19:20:09 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37705 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721Ab1CJAUH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2011 19:20:07 -0500
Received: by wwa36 with SMTP id 36so1328873wwa.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 16:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=4rJ4/QFoX89QdgM55TR7tapU4PDpOpuNwWXGL2oKIlo=;
        b=tPjigNyuk6ztDl/8WGNSi9yaQLVCach1ivC41YPmUdnPv3avf4WVpt7KHBNU5vV+79
         mqh+Krq8NCI1i8rrLWqcjpRSiLPSPdsCiOsULE6KRH13CoXx9GJBiBkx3s/2hyf/PcKy
         69DAQfKhQZO4PhUk1WJoshOAGPWl093+q2mKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=b/N5CMYgYGiI7ae8pesKXMd1XE+t4ho8O+i0qWLoDRGs+5muaKjoyY7aPidNFW5ZiO
         ULRKmca1cNgxt4qDN2d9xwzFy0mYtRzt1FxTUN75zaBT5RlebdC5fygyOSSXya7iGxab
         61cXEa9Uo1kYurkiHoQCNyjWxBZlFqVP/++VA=
Received: by 10.216.123.69 with SMTP id u47mr6359577weh.16.1299716406171; Wed,
 09 Mar 2011 16:20:06 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Wed, 9 Mar 2011 16:19:36 -0800 (PST)
In-Reply-To: <20110309215841.GC4400@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168777>

On Thu, Mar 10, 2011 at 4:58 AM, Jeff King <peff@peff.net> wrote:
> They will be looking at our ideas page at:
>
> =C2=A0 =C2=A0https://git.wiki.kernel.org/index.php/SoC2011Ideas
>
> If you have any ideas, please add them to the page!

Jeff, how is the "support multiple transport (torrent, bundle, http..)
cloning" going? The one that you were working on from the "initial
clone from bundle" thread? Is it ok to make it a SoC project
(presumably with at least bundle clone support)?
--=20
Duy
