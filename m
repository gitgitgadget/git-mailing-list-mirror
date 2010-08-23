From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 13/17] Documentation: remove stray backslash in
 show-branch discussion
Date: Mon, 23 Aug 2010 17:49:32 -0500
Message-ID: <20100823224932.GA16573@burratino>
References: <20100820101902.GA10356@burratino>
 <20100820103706.GM10407@burratino>
 <201008231318.30768.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 24 00:51:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnfrO-0005aj-9s
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 00:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473Ab0HWWvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 18:51:16 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62641 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab0HWWvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 18:51:16 -0400
Received: by qyk9 with SMTP id 9so3162573qyk.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 15:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qHeosO+DtjD5xmiGtVy+F53I1OykloB9UVrWgFhGVlA=;
        b=w8/HIN6V1V8JFsVNWtt/roJi4anJEoucFHpYiu5EnF91hVWSnxr5W0Muc/6TBHZRIU
         1Ww03V2ygwcpNy81PcE+wvRajCtrpDMGmtO8wjNudvcsWx7/Hu/qDmrt1ZhgyYduX3H/
         ccItfy6fAEGHIi0G8FfggllCYiIfz0+44PReA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cJaCOzkh3J6LS4Qf70BZ9ch3RWPPw4H4m10VGReyk4BgI+80Wp0iV8NZg6NpTD9eBW
         tHVNbR2+ne7HDkLtfODz56B+q0JhVS7jf6eDpcbGPN6sfZhTMvSfCmvnoM1xUFnUY4NW
         hdDH67IvRgE8QCsWYvpYBVuEf6o8Mo8Qv/wUY=
Received: by 10.229.241.146 with SMTP id le18mr4191892qcb.86.1282603875516;
        Mon, 23 Aug 2010 15:51:15 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id f15sm7659109qcr.13.2010.08.23.15.51.13
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 15:51:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008231318.30768.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154269>

Thomas Rast wrote:

> What does this apply on?  I tried 'git am -3' but it says

Sorry about that.  Hand-tweaking accident (I did not leave any
trailing context, so patch application tools are naturally not so
happy with it).

Thanks for the review!
