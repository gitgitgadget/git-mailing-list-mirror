From: Frans Pop <elendil@planet.nl>
Subject: Re: Add option in git-am to ignore leading text?
Date: Tue, 28 Jul 2009 21:19:17 +0200
Message-ID: <200907282119.17889.elendil@planet.nl>
References: <200907280513.59374.elendil@planet.nl> <20090728181524.GC16168@vidovic> <200907282111.14404.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 21:19:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVsCu-0003Ou-2g
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 21:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbZG1TTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 15:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbZG1TTT
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 15:19:19 -0400
Received: from Cpsmtpm-eml106.kpnxchange.com ([195.121.3.10]:61411 "EHLO
	CPSMTPM-EML106.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752121AbZG1TTT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 15:19:19 -0400
Received: from aragorn.fjphome.nl ([84.85.147.182]) by CPSMTPM-EML106.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Tue, 28 Jul 2009 21:19:18 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200907282111.14404.elendil@planet.nl>
Content-Disposition: inline
X-OriginalArrivalTime: 28 Jul 2009 19:19:18.0548 (UTC) FILETIME=[4DB35D40:01CA0FB8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124270>

On Tuesday 28 July 2009, Frans Pop wrote:
> Whether to do the same on Date: is less obvious, but I doubt that would
> ever be seen without at least one of the others (and the rules could
> specify that).

Hmm. Is a Date: pseudo header used at all? It isn't mentioned in the 
git-am man page, only From: and Subject: are.
