From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git as an sfc member project
Date: Sat, 23 Oct 2010 12:03:58 -0400
Message-ID: <4CC3076E.7050707@gmail.com>
References: <20101022183027.GA12124@sigill.intra.peff.net> <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com> <7vocalkf53.fsf@alter.siamese.dyndns.org> <20101022231820.GB25520@sigill.intra.peff.net> <AANLkTikxMtdvppLur4kuXffRn0G29NFv6ameTpaeY46G@mail.gmail.com> <20101023133948.GA2002@sigill.intra.peff.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 23 18:04:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9gZr-000748-31
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 18:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756280Ab0JWQEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 12:04:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36093 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587Ab0JWQEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 12:04:08 -0400
Received: by yxn35 with SMTP id 35so1327890yxn.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iLFIS27YYcQRvkCqPiHRh4jkO3V7SA2qxvdoUpTqpmc=;
        b=wbTkrJMI8Z18eNkWEn5NZcDyyyjH458esyDAJ9qHDBBayb89tFNZe2uZjTZwnqYyRe
         xnnpoQl7PJvVozED3kZf5sXgyuK26ehHj2MWAOsD0WT652kK1wgwMRlLNc7r+Rqk4+8B
         SPpfhekvM92HPIyvjNdTwjGtXH5AQhOi07dj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=N/CusRQGV0gsR3TS3lPQZrLc+hKKU7kCf2r5cvleHshw2nw+v9j5nMZ+I6zXTKbSOP
         AnV1wdnVfpbbUysXbN17qBtQ1uiLqV0H67Ng1QyoC/GyDXEtAgjM1z2fxclCelPTOidS
         TKAGbmgjy+c3DkYjIjRrB6Q1wYBF0Y9rzpkJY=
Received: by 10.42.174.71 with SMTP id u7mr3625777icz.136.1287849847642;
        Sat, 23 Oct 2010 09:04:07 -0700 (PDT)
Received: from [10.0.1.131] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id w5sm1254896vcr.6.2010.10.23.09.04.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 09:04:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
In-Reply-To: <20101023133948.GA2002@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159788>

On 10/23/2010 09:39 AM, Jeff King wrote:
> On Sat, Oct 23, 2010 at 11:52:26AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> Either way it doesn't matter, since I'm not interested in being a SF=
C
>> liasion. I just want to hack, not deal with issues like these (but
>> more power to people who want to).
>
> I didn't mean to pick on you, btw. It's just that I was surprised to =
see
> you, whose first commit was only 6 months ago, in the list of top
> contributors by lines of code. You're productive, but not _that_
> productive. :)

=46or what it's worth: my nominees are:

	Junio
	Shawn
	Jeff
	?
	?

This group has been involved a long time and each is or has been THE=20
maintainer at some point. More importantly, they have consistently=20
demonstrated critical thinking with a long term view and the ability to=
=20
handle the "politics" of the mailing list.

In addition to the above, I would like to 2 of the newer members of our=
=20
community in order to bring a different perspective to the=20
deliberations. Even better if they are USA based.
