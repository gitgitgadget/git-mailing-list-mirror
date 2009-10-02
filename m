From: gsky <gsky51@gmail.com>
Subject: Re: git only one file
Date: Fri, 2 Oct 2009 10:24:38 -0700 (PDT)
Message-ID: <25718014.post@talk.nabble.com>
References: <25140456.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 19:24:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtls4-0004WN-6r
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 19:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757463AbZJBRYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 13:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754756AbZJBRYe
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 13:24:34 -0400
Received: from kuber.nabble.com ([216.139.236.158]:35777 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbZJBRYd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 13:24:33 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Mtlry-0004eQ-0V
	for git@vger.kernel.org; Fri, 02 Oct 2009 10:24:38 -0700
In-Reply-To: <25140456.post@talk.nabble.com>
X-Nabble-From: gsky51@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129450>




synhedionn wrote:
> 
> with git add .  , a directory is expected, but I don't need all my files
> to be recorded, only one of my thousands, so how can I record just 1 file?
> 

git add /path/to/file
-- 
View this message in context: http://www.nabble.com/git-only-one-file-tp25140456p25718014.html
Sent from the git mailing list archive at Nabble.com.
