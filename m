From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 17:43:10 +0100
Message-ID: <fabb9a1e1002120843j493af52aq603ea4eb80d7294d@mail.gmail.com>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com> 
	<alpine.LNX.2.00.1002121111120.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 17:43:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfycF-0000V3-T1
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 17:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757248Ab0BLQne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 11:43:34 -0500
Received: from mail-yx0-f196.google.com ([209.85.210.196]:51224 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757063Ab0BLQnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 11:43:33 -0500
Received: by yxe34 with SMTP id 34so727840yxe.15
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=KOpW/zG7UaeidXwXOx3BauvjXBiEGHe9XbuG1EX69W8=;
        b=E0gxqBxdSVK3c2FYuSRrY/odsFme5D8boHIFV56P4Zi763QiRq6vghE+Rd6pLOQfwb
         T01yGhK3QCpu0SfQLG/7XLcAnXe3ac2qAwcCen/mhUvSXYismRNTuRVFx9u6cLPyWKY0
         izK+Tcx2xbR05F/05q1HFHTZkKS+LU1B7KefY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=DeTDhIIavF+tZN4H3LBnhILgUejJhxHXco3z/QpoEuCGW1kpLblzYxYTQb7WDwsSfu
         o9NXQtQ/FAEkOY9IGL5gqxI9WWHuPAG8bX+0IRWAmofv/LRKb0Ea3EyzJP5vlrbXgb31
         S0oyVtamKNqsfjy/aXG3lvclHgkDb1X2jzwxw=
Received: by 10.142.6.24 with SMTP id 24mr1065415wff.294.1265993010143; Fri, 
	12 Feb 2010 08:43:30 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1002121111120.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139724>

Heya,

On Fri, Feb 12, 2010 at 17:19, Daniel Barkalow <barkalow@iabervon.org> wrote:
> I've noticed that
> GSoC students are often shy about asking non-mentor developers to review
> their designs, and I'd like to review this before it's all written and
> under the end-of-summer crunch.

Since I'm (planning on) mentoring this student, I don't think you'll
have to worry about that too much. My experience with my own gsoc was
that the more exposure your work gets on the list the better, so the
student should send weekly 'state of the code' (including the code as
a patch) mails.

-- 
Cheers,

Sverre Rabbelier
