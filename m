From: Ittay Dror <ittayd@tikalk.com>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Thu, 05 Jun 2008 06:23:00 +0300
Message-ID: <48475C14.3000505@tikalk.com>
References: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com>	 <200806031856.11060.robin.rosenberg.lists@dewire.com>	 <20080603225418.GP12896@spearce.org>	 <200806040130.41654.robin.rosenberg.lists@dewire.com>	 <7bfdc29a0806032052w39010711q27e5257ef559908a@mail.gmail.com>	 <20080604042703.GQ12896@spearce.org> <7bfdc29a0806032345o98eb21dhb8714c8e04218a53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 05:24:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K465G-0002vA-6Z
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 05:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbYFEDXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 23:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbYFEDXG
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 23:23:06 -0400
Received: from smtp103.biz.mail.re2.yahoo.com ([68.142.229.217]:22902 "HELO
	smtp103.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751450AbYFEDXG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 23:23:06 -0400
Received: (qmail 1657 invoked from network); 5 Jun 2008 03:23:03 -0000
Received: from unknown (HELO ?10.10.2.7?) (ittayd@tikalk.com@212.143.191.180 with plain)
  by smtp103.biz.mail.re2.yahoo.com with SMTP; 5 Jun 2008 03:23:03 -0000
X-YMail-OSG: wEkOWMQVM1lVeBBJIq24p4gizHkYWDSznbdrz2.YY1mboUsXSWX5n3kROIb3OHkUtQxzZYJOFUNDlp7XkWh8tJ5AcHdOHZBJ6iCHJ6XD0M8yi31Gh2O6p7lPZkaheks-
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7bfdc29a0806032345o98eb21dhb8714c8e04218a53@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83848>



Imran M Yousuf wrote:
> I am sorry for my ignorance, I thought that maven was the most widely
> accepted java build tool, but what you said is a possibility.
>   
For what it's worth, Ant is the most popular build tool. Ant + Ivy (a 
dependency manager) is a great choice. My Next Best Thing (TM) is Gradle 
(www.gradle.org). I wouldn't choose Maven because it makes creating 
custom logic harder and some functionality (like assembly) is no mature. 
I can elaborate on the subject, if people are interested.

Ittay

-- 
Ittay Dror <ittayd@tikalk.com>
Tikal <http://www.tikalk.com>
Tikal Project <http://tikal.sourceforge.net>
