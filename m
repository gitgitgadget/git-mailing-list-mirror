From: david@lang.hm
Subject: Re: [linux.conf.au] VCS Interoperability
Date: Sun, 22 Jan 2012 13:12:27 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1201221310540.28747@asgard.lang.hm>
References: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com> <CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com> <CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com>
 <CALkWK0nsO2EBLUrO_iWAdGYpULt=oug4yPDnczX9c44hzdwzqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: David Michael Barr <davidbarr@google.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 22:24:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rp4u5-0005ox-FJ
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 22:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409Ab2AVVYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 16:24:21 -0500
Received: from mail.lang.hm ([64.81.33.126]:53086 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab2AVVYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 16:24:20 -0500
X-Greylist: delayed 708 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jan 2012 16:24:20 EST
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id q0MLCReT008959;
	Sun, 22 Jan 2012 13:12:27 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CALkWK0nsO2EBLUrO_iWAdGYpULt=oug4yPDnczX9c44hzdwzqg@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188971>

On Sun, 22 Jan 2012, Ramkumar Ramachandra wrote:

> 3. What are your thoughts on lib'ifying Git so that others can call
> into it using an API?

This is something that everyone agrees would be a good thing. There have 
been many people who have started projects to do so, but they have all 
stalled.

David Lang
