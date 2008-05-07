From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: Sort of a feature proposal
Date: Wed, 7 May 2008 18:00:35 +0200
Message-ID: <20080507160035.GA16163@cuci.nl>
References: <86fxsutbke.fsf@lola.quinscape.zz> <alpine.LFD.1.10.0805071139010.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 07 18:02:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtm5m-0004dS-6m
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 18:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982AbYEGQAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 12:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761966AbYEGQAm
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 12:00:42 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:39248 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761306AbYEGQAh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 12:00:37 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id C8BDE5462; Wed,  7 May 2008 18:00:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805071139010.23581@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81454>

Nicolas Pitre wrote:
>Maybe simply ignoring st_dev is the solution?  I hardly can see what 
>value it had to the other stat fields.

It determines the scope of st_ino.
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
Lady Astor: "Winston, if you were my husband, I'd put poison in your coffee."
 Churchill: "Nancy, if you were my wife, I'd drink it."
