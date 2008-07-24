From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: Re: [EGIT] Supported Eclipse version
Date: Thu, 24 Jul 2008 10:07:59 -0400
Message-ID: <89D1384A-403C-4E6E-816C-204AE0AAC30C@yahoo.ca>
References: <48888A2E.4030302@gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 16:09:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM1VD-0003t6-Qt
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 16:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbYGXOII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 10:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbYGXOIG
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 10:08:06 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:39630 "HELO
	smtp103.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751221AbYGXOIF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2008 10:08:05 -0400
Received: (qmail 21556 invoked from network); 24 Jul 2008 14:08:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:In-Reply-To:References:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=QCjuh2uuPv6tW4lql7g59wp1WRSK/uB1dxtiF/mV2HQ7wfi+6YKN70RQB/r0Y1VVkmtBSmWVlXK8IceBciGIIdpG8/CevwSfMrahfounWcuriZoSOc4I8ouJeMd1YCterHH06iKPYYHfGvnxjBQXFQM1ZPLA/8makoeiGFFmVUI=  ;
Received: from unknown (HELO ?192.168.3.32?) (jean_francois_veillette@207.96.147.134 with plain)
  by smtp103.mail.mud.yahoo.com with SMTP; 24 Jul 2008 14:08:03 -0000
X-YMail-OSG: VRBmc7wVM1kXQxkP3IpxgPNWxQL0MGJrX7cFCskXKl9VdlGJLf5aaSOl.WptnX7Ow2TUDdZCl5QMB467hXKjJ65XkHmF7xte8TSEr_oPYjAjL60uxMcBtXJt25oLlwKoKHQ-
X-Yahoo-Newman-Property: ymail-3
In-Reply-To: <48888A2E.4030302@gmail.com>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89884>

> Maybe some users (or developers) from mailing list can tell us  
> about their opinion?

I think keeping comptability for one version behind the  
'current' (still compatible 3.3 while 3.4 is the current) is a  
reasonable goal.
3.2 is relatively far behind, tools vendor had time to get up to date  
by now.
If a user is using a third party version of eclipse based on 3.2,  
then I guess he should not expect egit to work with it (he should  
just pray and hope for the best).

For myself, I use 3.3.x, I have not yet moved to 3.4 since my main  
plugin (WOLips) is not ready yet for 3.4.

- jfv
