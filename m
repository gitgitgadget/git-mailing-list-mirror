From: Aubrey <aubreylee@gmail.com>
Subject: Re: Quick question: how to generate a patch?
Date: Tue, 28 Feb 2006 10:48:11 +0800
Message-ID: <6d6a94c50602271848g4bf18669na6167a78a74bf834@mail.gmail.com>
References: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com>
	 <Pine.LNX.4.64.0602270801280.22647@g5.osdl.org>
	 <6d6a94c50602270818k5f82bb8ft68a19899db3db636@mail.gmail.com>
	 <Pine.LNX.4.64.0602270830330.22647@g5.osdl.org>
	 <6d6a94c50602270902k2c06aaffw7e70268b0753ef64@mail.gmail.com>
	 <44033241.6070001@op5.se>
	 <Pine.LNX.4.64.0602270923120.22647@g5.osdl.org>
	 <6d6a94c50602271755v41e0d31ch25892192547003a9@mail.gmail.com>
	 <Pine.LNX.4.64.0602271802110.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 03:48:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDuuN-0000l5-Rz
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 03:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWB1CsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 21:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWB1CsN
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 21:48:13 -0500
Received: from pproxy.gmail.com ([64.233.166.176]:3895 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932128AbWB1CsM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 21:48:12 -0500
Received: by pproxy.gmail.com with SMTP id e30so830691pya
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 18:48:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SI1JH5L6WL14OkeAltpJ8lJz88aKTQRkB3sx3xcCa+cIvvDQmV8I/hsLk9ZWaCdbiMOsBEA4zG07gQGpBo5Mx8A/Jp8qoWDaw6l8g4P5K8n6TwK2fsyvif+ELezvuZzQWHJIG5UgCXuOhuqQ+27Oheba6jXpdSmpldkR32Q/bS4=
Received: by 10.65.105.11 with SMTP id h11mr5026qbm;
        Mon, 27 Feb 2006 18:48:11 -0800 (PST)
Received: by 10.65.185.6 with HTTP; Mon, 27 Feb 2006 18:48:11 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602271802110.22647@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16908>

> If you can re-create this at will, it would be interesting to see _what_
> makes git think you've modified a file. A small mod to "read-cache.c" like
> the appended patch should give you (very very verbose) output that could
> help us figure this out.
Oops, It's my fault. My mistake is that copy the clone git directory
to another directory for backup. And work on another directory. Sorry
for my incaution.

-Aubrey
