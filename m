From: Craig Taylor <c@gryning.com>
Subject: Re: install does not obey DESTDIR or --prefix for perl modules
Date: Mon, 21 Sep 2009 20:46:53 +0100
Message-ID: <20090921194653.GG8173@gryning.com>
References: <20090921160551.GD8173@gryning.com> <Ow6bpZou9Vi0tKlyAN-qfjlAAtXvMqpXEAiG54zZ3C8fLI_6_Bt3oA@cipher.nrlssc.navy.mil> <7vskeguqmb.fsf@alter.siamese.dyndns.org> <20090921191943.GE8173@gryning.com> <1253561929-sup-8931@ntdws12.chass.utoronto.ca>
Reply-To: c@gryning.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Sep 21 21:47:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpoqu-0004V7-LP
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 21:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbZIUTrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 15:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbZIUTrD
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 15:47:03 -0400
Received: from 87-194-167-47.bethere.co.uk ([87.194.167.47]:51104 "EHLO
	jolt.ukmail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbZIUTrD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 15:47:03 -0400
Received: from craigt by jolt.ukmail.org with local (Exim 4.63)
	(envelope-from <c@gryning.com>)
	id 1Mpoqb-00075x-P7; Mon, 21 Sep 2009 20:46:53 +0100
Content-Disposition: inline
In-Reply-To: <1253561929-sup-8931@ntdws12.chass.utoronto.ca>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128906>

On Mon, Sep 21, 2009 at 03:40:04PM -0400, Ben Walton wrote:
> Excerpts from Craig Taylor's message of Mon Sep 21 15:19:43 -0400 2009:
> 
> > Exactly as you describe here, different paths but same goal.
> > All binaries follow the DESTDIR path except the perl modules.
> 
> I haven't had this problem and I've been packaging git for solaris (8
> or newer) since early 2009.  If you're interested in my build notes,
> feel free to ping me.
> 
> Thanks
> -Ben

Will take you up on this. I'll re-raise this if they don't help.

Thanks
CraigT

-- 

c^ [c%5e]

Even when you are standing in front of defeat, do it smiling.
