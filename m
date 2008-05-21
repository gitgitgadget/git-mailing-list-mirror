From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: RE: git cvsimport error
Date: Wed, 21 May 2008 14:51:50 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794301FC8B2D@emailmn.mqsoftware.com>
References: <799406d60805211214r6315268ard77678eb2ec5d732@mail.gmail.com> <799406d60805211239n42c39ea6iaa41a9ab379cafaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "Adam Mercer" <ramercer@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 21 21:53:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyuMf-00045N-Dd
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 21:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758738AbYEUTvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 15:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758226AbYEUTvw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 15:51:52 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:14279 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566AbYEUTvv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2008 15:51:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <799406d60805211239n42c39ea6iaa41a9ab379cafaa@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git cvsimport error
Thread-Index: Aci7erxKNM8wOa/vSbiARpNkIhDf2gAAREPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82576>


> On Wed, May 21, 2008 at 2:14 PM, Adam Mercer 
> <ramercer@gmail.com> wrote:
> 
> > Fetching glue/ldbd.py   v 1.1
> > Unknown: error
> > [ram@mimir ~]$
> 
> Done some digging with cvsps itself and it looks like the 
> lbdb.py,v file has become corrupted from a very early version...
> 
> Is there a way that I can tell git to ignore the early revisions?
> 
Not a cvsps expert, but I'm at the same point as you in converting a
repo ;-)  Would the -d option on cvsps do what you want?

> Cheers
> 
> Adam
> --
> 
Cheers,
Craig
