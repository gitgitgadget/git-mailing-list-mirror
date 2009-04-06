From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [EGIT] [PATCH RFC v1 0/5] Add (static) ignore functionality to
 EGit
Date: Mon, 06 Apr 2009 18:51:17 +0200
Message-ID: <49DA3305.7090601@pelagic.nl>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl> <20090405210248.GA23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 18:54:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqs5G-000537-ER
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 18:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705AbZDFQvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 12:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbZDFQvV
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 12:51:21 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:38361 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755705AbZDFQvU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 12:51:20 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 9070158BD9F;
	Mon,  6 Apr 2009 18:51:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090405210248.GA23604@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115854>

Shawn O. Pearce wrote:
> JGit and EGit are holding the line on Java 5 support; that means
> that String.isEmpty() must be spelled as String.length() == 0
> (isEmpty was added in Java 6).

just looked in the project settings for org.spearce.egit.core and it has
java 1.5 style specified _and_ eclipse does not give me a warning on the
*.isEmpty() calls. Am i missing something here?
