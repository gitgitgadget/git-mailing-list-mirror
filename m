From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 09:42:53 -0600
Message-ID: <625fc13d0701180742t703f4f0ei8847c32fe4e0dcfd@mail.gmail.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	 <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>
	 <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com>
	 <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>
	 <45AF7FE8.5060003@op5.se>
	 <81b0412b0701180641v55987657t331d6a1868dabee0@mail.gmail.com>
	 <Pine.LNX.4.63.0701181547440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701180653i7cc0c87md7a9c94a10fa3b24@mail.gmail.com>
	 <Pine.LNX.4.63.0701181615360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701180737m49895d24td104b8dd2579de44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 16:43:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7ZPl-0006H1-Kk
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 16:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbXARPm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 10:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbXARPm4
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 10:42:56 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:61996 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbXARPmz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 10:42:55 -0500
Received: by nf-out-0910.google.com with SMTP id o25so217491nfa
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 07:42:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MKJ/KJ5TvCDSk854XVo2/VQg+mIoUrKgqJ26scKfoo8dUPICw0mQMjQWvjMyxI5JFux+KfMsfX9h/XR4ZNApuXBUVrduFMX/EqJArv0iLaJ3Cfcim/Dd52u0ZYTdjN/93z2+ibEXJ2zOFF+9ikZgTUFVOQ/S/z7rl9Mnu1byXM0=
Received: by 10.82.136.4 with SMTP id j4mr268499bud.1169134973691;
        Thu, 18 Jan 2007 07:42:53 -0800 (PST)
Received: by 10.82.107.1 with HTTP; Thu, 18 Jan 2007 07:42:53 -0800 (PST)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701180737m49895d24td104b8dd2579de44@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37112>

On 1/18/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> > The template mechanism can handle _all_ files in GIT_DIR. Just drop a
> > "config" into the templates directory, and you're settled.
>
> I'm settled! From now on I will never have any objections regarding
> any defaults as long as they have a config option :)

Whew.  Cool :)

Junio, will this go into git at some point soon-ish?  I'm looking
forward to it...

josh
