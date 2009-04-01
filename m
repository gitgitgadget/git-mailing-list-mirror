From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: "git clone --depth <depth>" producing history with <depth + 1>
 commits?
Date: Wed, 01 Apr 2009 21:39:44 +0200
Message-ID: <49D3C300.1040303@hartwork.org>
References: <49CBB490.8040908@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 21:41:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp6JY-0000MK-3I
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 21:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764070AbZDATjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 15:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763016AbZDATjw
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 15:39:52 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.44]:55626 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761452AbZDATjv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 15:39:51 -0400
Received: from [85.179.23.219] (helo=[192.168.0.3])
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1Lp6Ho-0003cd-LR
	for git@vger.kernel.org; Wed, 01 Apr 2009 21:39:44 +0200
User-Agent: Thunderbird 2.0.0.19 (X11/20090216)
In-Reply-To: <49CBB490.8040908@hartwork.org>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115410>

Sebastian Pipping wrote:
> Is "git clone --depth 1 <ropository>" expected to give a history
> with 2 commits?  "--depth 2" gives 3 commits, "--depth 0" all.
> 
> Is that by design or a bug?

Anyone?  Is "git clone --depth 1 <ropository>" really
supposed to produce a history holding _two_ commits?  Why so?



Sebastian
