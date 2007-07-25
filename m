From: Noel Grandin <noel@peralex.com>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 17:34:27 +0200
Message-ID: <46A76D83.6020005@peralex.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <693D0FFF-B271-4781-BCE2-3BF00C8BF426@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 08:32:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDwtb-0006Vx-KK
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 08:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbXGZGcV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 02:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753782AbXGZGcU
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 02:32:20 -0400
Received: from [41.207.227.243] ([41.207.227.243]:59516 "EHLO mail.peralex.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753356AbXGZGcU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 02:32:20 -0400
X-Greylist: delayed 53812 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jul 2007 02:32:18 EDT
Received: from [192.168.1.75] (noel.ct [192.168.1.75])
	by mail.peralex.com (8.14.1/8.14.1) with ESMTP id l6PFYR2e004183;
	Wed, 25 Jul 2007 17:34:27 +0200 (SAST)
	(envelope-from noel@peralex.com)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <693D0FFF-B271-4781-BCE2-3BF00C8BF426@zib.de>
X-Enigmail-Version: 0.95.2
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.61 on 192.168.1.7
X-Synonym: Copied by Synonym (http://www.modulo.ro/synonym) to: mailbackup2@peralex.com, mailbackup2@peralex.com
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (mail.peralex.com [192.168.1.7]); Wed, 25 Jul 2007 17:34:28 +0200 (SAST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53780>


Cygwin tries to make Windows look like unix (from a command-line POV),
so it very much runs against the grain of "real" windows programs.

Plus, it's a pain to install and invoke,
and doesn't deal nicely with real windows paths (it maps the windows
filesystem to a unix-y style single root path structure),


Steffen Prohaska wrote:
>
> On Jul 25, 2007, at 12:35 PM, Dmitry Kakurin wrote:
>
>> How serious are you guys about Windows support?
>> I'm talking fully-functional port, not Cygwin.
>
> What's wrong with the Cygwin port?
>
> Is it just that windows developer hate cygwin because it's to
> complex to install or is there any severe limitation?
> functionality? stability? performance?
>
> I'm personally only working on Windows if force to, but people
> are asking me the same question that you have. Does git
> seriously and fully support Windows?
>
>     Steffen
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Disclaimer: http://www.peralex.com/disclaimer.html
