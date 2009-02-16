From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC - draft] List of proposed future changes that are backward 
	incompatible
Date: Mon, 16 Feb 2009 15:40:11 +0100
Message-ID: <bd6139dc0902160640n3a95223j71ae7f26bc0ff0b4@mail.gmail.com>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
	 <alpine.DEB.1.00.0902152358330.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.10.0902151613110.14911@asgard.lang.hm>
	 <alpine.DEB.1.00.0902160016230.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.10.0902151636510.14911@asgard.lang.hm>
	 <alpine.DEB.1.00.0902161121290.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.10.0902160731420.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 15:42:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ4fH-0004Ky-Hb
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 15:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbZBPOkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 09:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbZBPOkO
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 09:40:14 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:33411 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbZBPOkN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 09:40:13 -0500
Received: by fg-out-1718.google.com with SMTP id 16so241645fgg.17
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 06:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=T4N5BCSHVDUVyEdf9bgw3D974vPIiR02nnZ/14tDB0c=;
        b=UskntHXjIHF6lGRoS6Lq/dIgbkdAHqyIO0ZmxjIb2EFE9hYTMyMmWgxJ21GtVGP2EF
         1fxy6LGy8plXszckz6wdmvi556xhbb4WxTNPhl5DBjDqklWvDZk6OnPxgiEQQaqrWcfP
         PRrU56m1xI5cUyKKlAbM9r61zG0GfhLgDC2v8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=pfSZ6mEyUpz8GS4dKveODkm8pHIWU5qOK7xrUA++2F7Ak8gRdb7YBkrQgUh8cT1Z/f
         5D5p5D8qfHwm11/JNJR4yO9kROaQJOh9BTAPIsN54C7TBLdJdf8jq0dbw0YlzkloLTRb
         zrIgYfHXDML2FAbwpA6udTIbQ/wlpsLB33rXs=
Received: by 10.86.66.19 with SMTP id o19mr1498537fga.0.1234795211121; Mon, 16 
	Feb 2009 06:40:11 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.0902160731420.14911@asgard.lang.hm>
X-Google-Sender-Auth: 2229ba0395ed34b0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110185>

On Mon, Feb 16, 2009 at 16:33,  <david@lang.hm> wrote:
> if it is the correct thing to do with some workloads, it's not being
> deprecated. if it was deprecated then it is a capability that would be
> scheduled for complete removal, and nobody should ever use. not just the
> case where it needs to be used carefully, and you are putting in a warning
> about it.

Nitpicking much? The reasons why the warning/default-to-disallow are
being put in place have been explained, what value did your message
above add to the discussion? From my point of view it didn't add much,
if anything at all. It might be a good idea to end this thread here,
as Junio requested. If you feel the undying need to continue this
discussion, please do not do so in this thread.

Thank you.

-- 
Cheers,

Sverre Rabbelier
