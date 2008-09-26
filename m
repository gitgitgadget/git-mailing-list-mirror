From: "Li Frank-B20596" <Frank.Li@freescale.com>
Subject: RE: [QGit] Some suggestion
Date: Fri, 26 Sep 2008 13:43:14 +0800
Message-ID: <7FD1F85C96D70C4A89DA1DF7667EAE9607A0D9@zch01exm23.fsl.freescale.net>
References: <gbak2u$v9b$1@ger.gmane.org> <7FD1F85C96D70C4A89DA1DF7667EAE96079EDF@zch01exm23.fsl.freescale.net> <e5bfff550809250451q578b8e10r75c043d307a63f28@mail.gmail.com> <7FD1F85C96D70C4A89DA1DF7667EAE96079FBB@zch01exm23.fsl.freescale.net> <e5bfff550809250934l47c48440m332764491ff5391@mail.gmail.com> <7FD1F85C96D70C4A89DA1DF7667EAE9607A00A@zch01exm23.fsl.freescale.net> <e5bfff550809252215v72bb4633s17b5c1a8c39f55ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 07:44:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj67u-0000M2-2R
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 07:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbYIZFnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 01:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbYIZFnR
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 01:43:17 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:57385 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbYIZFnQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2008 01:43:16 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m8Q5hAKM000362
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 22:43:11 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net [10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m8Q5h87e003249
	for <git@vger.kernel.org>; Fri, 26 Sep 2008 00:43:09 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <e5bfff550809252215v72bb4633s17b5c1a8c39f55ff@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [QGit] Some suggestion
Thread-Index: AckflvTM81415QLFQDKMW+xy8pAu3wAAdeWg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96826>

I think orange color of "Working dir changes" in Rev List view is good. 

"MAGIC WAND" is google feature. 
I think the message of "Filter on <lib/blame.tcl>" at title omitted by
user early. 

I have some suggestions. 
	Option 1: Change "Rev List" to "Rev List Filtered", or add
filter icon before "Rev List"
	Option 2: Change "Short Log"  to "Short Log Filter On
<Lib/blame.tcl>"
	Option 3: Add bar between tab and list, show current filter
information 

-----Original Message-----
From: Marco Costalba [mailto:mcostalba@gmail.com] 
Sent: Friday, September 26, 2008 1:16 PM
To: Li Frank-B20596
Cc: git@vger.kernel.org
Subject: Re: [QGit] Some suggestion

On Fri, Sep 26, 2008 at 3:55 AM, Li Frank-B20596
<Frank.Li@freescale.com> wrote:
> Thank you for your support!
> Can I compare with other version at file view?

After selecting with CTRL+RIGHT CLICK as already descrived click on the
file name, you'll be pointed to the part of the diff related to your
file.

Another option is to choose one commit, click on a file name in the
right bottom pane, then press the MAGIC WAND button, then commits will
be reloaded with path limiter and you will see only commits that modify
the selected file. Toggle magic wand button to restore original view.

> I think highlight author at file view is not high light, can use 
> different color?

What is the color you would like ? Possibly in RGB format.

Marco
