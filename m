From: Walter Bright <boost@digitalmars.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 12:25:44 -0700
Organization: Digital Mars
Message-ID: <fbs8jf$1cd$2@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <fbr2iv$ugg$1@sea.gmane.org> <FEA805F3-A6BA-4C76-B2C7-E28C00FDD801@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 21:30:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITjXK-00021y-6h
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 21:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbXIGTac (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 15:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbXIGTac
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 15:30:32 -0400
Received: from main.gmane.org ([80.91.229.2]:52702 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913AbXIGTac (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 15:30:32 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1ITjWk-00073P-7e
	for git@vger.kernel.org; Fri, 07 Sep 2007 21:30:02 +0200
Received: from c-24-16-50-251.hsd1.mn.comcast.net ([24.16.50.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 21:30:02 +0200
Received: from boost by c-24-16-50-251.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 21:30:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-50-251.hsd1.mn.comcast.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <FEA805F3-A6BA-4C76-B2C7-E28C00FDD801@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58059>

Wincent Colaiuta wrote:
> But once again I think Git falls into a special category where the 
> design makes the "hassle" of developing in C worth it.

That may very well be true. I've never looked at the source code for 
git, so I'm not in any position to judge it. Nor do I suggest 
translating a debugged, working, 80,000 line project into another language.

My comments here are in more general terms.
