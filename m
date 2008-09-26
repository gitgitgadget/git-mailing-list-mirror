From: "Li Frank-B20596" <Frank.Li@freescale.com>
Subject: RE: [QGit] Some suggestion
Date: Fri, 26 Sep 2008 22:57:52 +0800
Message-ID: <7FD1F85C96D70C4A89DA1DF7667EAE9607A1DA@zch01exm23.fsl.freescale.net>
References: <gbak2u$v9b$1@ger.gmane.org> <7FD1F85C96D70C4A89DA1DF7667EAE96079EDF@zch01exm23.fsl.freescale.net> <e5bfff550809250451q578b8e10r75c043d307a63f28@mail.gmail.com> <7FD1F85C96D70C4A89DA1DF7667EAE96079FBB@zch01exm23.fsl.freescale.net> <e5bfff550809250934l47c48440m332764491ff5391@mail.gmail.com> <7FD1F85C96D70C4A89DA1DF7667EAE9607A00A@zch01exm23.fsl.freescale.net> <e5bfff550809252215v72bb4633s17b5c1a8c39f55ff@mail.gmail.com> <7FD1F85C96D70C4A89DA1DF7667EAE9607A0D9@zch01exm23.fsl.freescale.net> <e5bfff550809260337o1523995ele3333c0de9295393@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 17:00:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjEmu-0007Hh-QK
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 16:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbYIZO6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 10:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbYIZO6J
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 10:58:09 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:53316 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbYIZO6I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2008 10:58:08 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id m8QEvrxF004984
	for <git@vger.kernel.org>; Fri, 26 Sep 2008 07:57:54 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net [10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m8QEvpsl027788
	for <git@vger.kernel.org>; Fri, 26 Sep 2008 09:57:52 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <e5bfff550809260337o1523995ele3333c0de9295393@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [QGit] Some suggestion
Thread-Index: Ackfw+qPedz+9lIWQDO9TR1nTh/RvwAIbFQg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96863>

Option 1: 
	Telling user just filted is better than nothing. Is it possible
add tool button tip. 
	When mouse over 'Rev list [Felted]", show what filtering.

Best regards
Frank Li 

-----Original Message-----
From: Marco Costalba [mailto:mcostalba@gmail.com] 
Sent: Friday, September 26, 2008 6:38 PM
To: Li Frank-B20596
Cc: git@vger.kernel.org
Subject: Re: [QGit] Some suggestion

On Fri, Sep 26, 2008 at 7:43 AM, Li Frank-B20596
<Frank.Li@freescale.com> wrote:
>
> I have some suggestions.
>        Option 1: Change "Rev List" to "Rev List Filtered"

This is the more correct but we don't have the space to write on what
files it is filtering


>        Option 2: Change "Short Log"  to "Short Log Filter On 
> <Lib/blame.tcl>"

This is less correct because short log has nothing to do with filtering,
but here there is more space...


>        Option 3: Add bar between tab and list, show current filter 
> information
>

Too complicated and space wasteful IMO.

Marco
