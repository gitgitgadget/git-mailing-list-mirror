From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [PATCH JGIT] Method invokes inefficient Number constructor; use
 static valueOf instead
Date: Thu, 19 Mar 2009 10:45:37 +0100
Message-ID: <49C21441.80000@pelagic.nl>
References: <49C20D13.2050908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 10:47:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkEqI-0003ZI-K5
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 10:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827AbZCSJpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 05:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344AbZCSJpm
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 05:45:42 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:40817 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755300AbZCSJpm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 05:45:42 -0400
Received: from [192.168.0.50] (Paul.internal.Hupie.com [192.168.0.50])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id DD64158BDBA;
	Thu, 19 Mar 2009 10:45:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <49C20D13.2050908@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113742>



Yann Simon wrote:
> From FindBugs:

+1

also, junit would be another +1 AFAIC :-)
