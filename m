From: Marco <netuse@lavabit.com>
Subject: Re: Compiling fails on SunOS
Date: Fri, 25 Feb 2011 12:33:29 +0100
Message-ID: <20110225123329.767ce083@glyph>
References: <20110225100954.37c00fea@glyph>
 <20110225095731.GC2908@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 25 12:33:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psvvf-0008JH-BA
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 12:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485Ab1BYLdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 06:33:42 -0500
Received: from lo.gmane.org ([80.91.229.12]:35245 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754065Ab1BYLdl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 06:33:41 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PsvvY-0008Gi-Rn
	for git@vger.kernel.org; Fri, 25 Feb 2011 12:33:40 +0100
Received: from miun108-177.dynamic.miun.se ([193.10.108.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 12:33:40 +0100
Received: from netuse by miun108-177.dynamic.miun.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 12:33:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: miun108-177.dynamic.miun.se
X-Newsreader: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167901>

On 2011-02-25 Jonathan Nieder <jrnieder@gmail.com> wrote:

> Marco wrote:
> 
> > Are there any known workarounds or solutions?
> 
> Random guess: have you tried running "gmake"?

Stupid me. Sorry for the noise.

> Hope that helps,

It did.

Marco
