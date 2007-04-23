From: "Raimund Bauer" <ray@softwarelandschaft.com>
Subject: RE: cvsimport problem
Date: Mon, 23 Apr 2007 11:04:23 +0200
Organization: Softwarelandschaft
Message-ID: <000e01c78586$63101a20$0b0aa8c0@abf.local>
References: <462C71E2.2040007@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: "'Rogan Dawes'" <discard@dawes.za.net>,
	"'Raimund Bauer'" <raimund.bauer@abf-int.de>
X-From: git-owner@vger.kernel.org Mon Apr 23 11:04:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfuTQ-0003xa-Pt
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 11:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbXDWJEi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 05:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754015AbXDWJEi
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 05:04:38 -0400
Received: from s15211414.onlinehome-server.info ([87.106.16.196]:58232 "EHLO
	s15211414.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753993AbXDWJEh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 05:04:37 -0400
Received: (qmail 5910 invoked from network); 23 Apr 2007 11:10:07 +0200
Received: from host-62-245-155-90.customer.m-online.net (HELO swl011) (62.245.155.90)
  by s15211414.onlinehome-server.info with SMTP; 23 Apr 2007 11:10:07 +0200
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <462C71E2.2040007@dawes.za.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45305>

Rogan Dawes wrote:

> Raimund Bauer wrote:
> > I have already imported lots of cvs repositories into git 
> > repostitories on our server, which I then clone from several client 
> > machines. This weekend I ran into a module I couldn't clone:
> > 
> > $ cvs -d 
> :pserver:anonymous@cvs.drupal.org:/cvs/drupal-contrib login  
> > enter passwort 'anonymous' $ git cvsimport -d 
> > :pserver:anonymous@cvs.drupal.org:/cvs/drupal-contrib -v -i 
> > contributions/modules/node_import Initialized empty Git 
> repository in
> > /home/ray/drupal/modules/node_import/.git/
> > Running cvsps...
> > connect error: Network is unreachable
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Is this maybe the reason?

No, not sure why, but I _always_ get this message, also on my success
imports and the incremental updates I'm doing regularely.

> Rogan

-- 
best regards

  Ray
