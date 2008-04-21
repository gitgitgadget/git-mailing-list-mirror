From: "Benjamin Collins" <aggieben@gmail.com>
Subject: Re: git-gui hangs on read
Date: Mon, 21 Apr 2008 16:05:20 -0500
Message-ID: <b3889dff0804211405r6f477f3w3216670c91c4fb9a@mail.gmail.com>
References: <b3889dff0804210723s620363fdscba43c79dbb62d55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 23:07:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo3DL-0001oz-1h
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 23:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbYDUVF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 17:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbYDUVF0
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 17:05:26 -0400
Received: from el-out-1112.google.com ([209.85.162.180]:44504 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbYDUVF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 17:05:26 -0400
Received: by el-out-1112.google.com with SMTP id n30so535815elf.21
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 14:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=N7A3Hjv+z4gGLLim7Tt5P26yOa02L3UKscN4KF+utR8=;
        b=URxir2SMEosJDA2H9nlOCTMcFJSfHfk15bt3pL3HwHwEKd0RL+ORv5HX2ArJU9EKxBh0RcnVh2eiefa6oFQ5einQ/5urmfPnfqHYNz0RBTOLjUmcve4q3/DAJJjpoJLhDD6n+q/5/aDKizAZzbaECdEhxYBkzB+yqnTScPGqnaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gw1iyX0Q/BHLBkz2/kI5wTX9usg0sci1VyovOzNWDuN+pPnAsVlZjLG/BCWxmvemlRmNZce6K4RzhaZP+/hUYr+cGzIXIbRuf2Q7Ep9SNPyObxy8gbNVOP1IN91zOr0NBQeLAcH5xHnEXkEn4wjc/bfOJdz6UucVbbHvtbQJgM0=
Received: by 10.141.29.14 with SMTP id g14mr3583863rvj.241.1208811920610;
        Mon, 21 Apr 2008 14:05:20 -0700 (PDT)
Received: by 10.141.75.14 with HTTP; Mon, 21 Apr 2008 14:05:20 -0700 (PDT)
In-Reply-To: <b3889dff0804210723s620363fdscba43c79dbb62d55@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80039>

On Mon, Apr 21, 2008 at 9:23 AM, Benjamin Collins <ben.collins@acm.org> wrote:
> I just upgraded a few machines (RHEL 4.4) to the latest stable, and
>  git-gui stopped working.  It just hangs forever if it's in a git
>  repository.

Still don't know what the deal is (no time to investigate, yet), but
1.5.4 doesn't have this issue.

-- 
Benjamin A. Collins <aggieben@gmail.com>
