From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Cover letter
Date: Tue, 8 Jan 2008 14:13:46 +0100
Message-ID: <4d8e3fd30801080513q4402b776kfd587c7c558b1f8a@mail.gmail.com>
References: <4d8e3fd30801080452g71c3d3dx39f2ec805239ef01@mail.gmail.com>
	 <478375FB.405@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Gustaf Hendeby" <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Tue Jan 08 14:14:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCEHZ-00068Z-Df
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 14:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349AbYAHNNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 08:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754281AbYAHNNt
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 08:13:49 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:53975 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbYAHNNt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 08:13:49 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1801508nze.1
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 05:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fMERGn6LFnUS6X+DIStG/zYzCITeULtc/jHhYa9Nx+E=;
        b=o01Hx99yBKUSOBqV+XFNu2zH9D/5apfk4gZcAbUQV2cg82VlkCjAVv2v9A2YMIuh1vcLnW9YBGG7Zpu2AAOf6aVrWQFcKs3P0Tq/+0h2sl+dqdaBRQM6ESUaknL6x63IPTJ5vzVxB7gv8LdDLb0HvaKTikPquQMKZ+NKF+UQH5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VtQNpW9BD7hWNCrRZJ6AuH80Q4S2VJsDtegBExbc/KYKSpzW4xI+vdHz3MKpO5qQgFF9KedVvrBD2p+WWvmxQj0rR7/O3C1Ts9pwGNQO7PaeeGplggPOYFvI0EP/nOPp0pdXKqBf1wGMOxAbv/DisvFrq4ElTNqemlacSCu9tgg=
Received: by 10.142.105.14 with SMTP id d14mr998206wfc.67.1199798026112;
        Tue, 08 Jan 2008 05:13:46 -0800 (PST)
Received: by 10.143.162.9 with HTTP; Tue, 8 Jan 2008 05:13:46 -0800 (PST)
In-Reply-To: <478375FB.405@isy.liu.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69876>

On Jan 8, 2008 2:09 PM, Gustaf Hendeby <hendeby@isy.liu.se> wrote:
> > This is working fine but since I'm going to push out a queue of patches
> > it would be nicer to script everything with git-send-email.
> >
> > I know I have to configure git in order to use the gmail's smtp server,
> > I know how to tell git-send-email where to pick up the patches but I fail
> > to understand how I can write a cover letter and let it be part of the patch
> > queue.
>
> Use the switch --compose to git send-email, that should open up an
> editor and let you write a cover letter to go with the patches.

Not enough coffe :-)

The option is there and well documented.
Thanks Gustaf.

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
