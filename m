From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Git-1.6.0.2-preview20080923
Date: Sun, 4 Jan 2009 11:55:53 -0800 (PST)
Message-ID: <97877aa2-fd56-4493-9e14-b449709c75a9@w1g2000prk.googlegroups.com>
References: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de> <691F01A6-CA78-46DA-8388-C8339A3F0F04@zib.de> 
	<B463062F-DD48-44A7-B2BB-8E5E0D177616@zib.de> <Pine.LNX.4.64.0809261026000.10516@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sun Jan 04 20:57:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJZ6C-000687-GW
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 20:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759415AbZADTz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 14:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758697AbZADTz5
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 14:55:57 -0500
Received: from yw-out-2122.google.com ([74.125.46.24]:64322 "EHLO
	yw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757333AbZADTz4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jan 2009 14:55:56 -0500
Received: by yw-out-2122.google.com with SMTP id 4so2175831ywd.1
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 11:55:53 -0800 (PST)
Received: by 10.151.8.8 with SMTP id l8mr399277ybi.5.1231098953644; Sun, 04 
	Jan 2009 11:55:53 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0809261026000.10516@ds9.cixit.se>
X-IP: 77.21.90.61
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) 
	Gecko/2008120122 Firefox/3.0.5 (.NET CLR 3.5.30729),gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104537>

> > I updated the installer to Git-1.6.0.2-preview20080923.
>
> One issue that I see is that the installer does not seem to clean up
> the previously installed version on upgrade. I installed over the
> previous version to C:\Git, and I now have two git-add.exe files:
>
> =A0Directory of c:\git\bin
>
> 2008-06-22 =A018:41 =A0 =A0 =A0 =A0 =A0 925=A0184 git-add.exe
>
> =A0Directory of c:\git\libexec\git-core
>
> 2008-09-23 =A007:55 =A0 =A0 =A0 =A0 =A0 881=A0664 git-add.exe

I'm currently testing a patch that fixes this.

--
Sebastian
