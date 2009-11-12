From: rhlee <richard@webdezign.co.uk>
Subject: Re: Working on merged branches whilst seeing current master
Date: Thu, 12 Nov 2009 06:57:42 -0800 (PST)
Message-ID: <1258037862366-3993313.post@n2.nabble.com>
References: <1257959806206-3987667.post@n2.nabble.com> <20091111215727.GK27518@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 15:58:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8b7z-0005H8-6t
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 15:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbZKLO5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 09:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753178AbZKLO5j
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 09:57:39 -0500
Received: from kuber.nabble.com ([216.139.236.158]:60152 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbZKLO5g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 09:57:36 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1N8b7G-0005W7-Bv
	for git@vger.kernel.org; Thu, 12 Nov 2009 06:57:42 -0800
In-Reply-To: <20091111215727.GK27518@vidovic>
X-Nabble-From: rhlee <richard@webdezign.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132770>


Thanks for the help Nicolas,

That cleared up the issue a lot for me.


Nicolas Sebrecht-3 wrote:
> 
>>                                      Yes I know I probably should not be
>> working like this. My branches should be wholly independent. But I doing
>> web
>> development not kernel development so there is much less modularity and
>> branches/features have a tendency to creep into one another.
> 
> This should not be the case. Modularity in the release process and the
> development strategy is not tied to "what I am developing". I'm doing
> some web development too and have no difficulty around this point.
> 

Just to clarify. Do you mean that this should not be the case that you get
feature creep in branches or the fact that this happens does interfere with
your release process/development strategy.

Regards,

Richard
-- 
View this message in context: http://n2.nabble.com/Working-on-merged-branches-whilst-seeing-current-master-tp3987667p3993313.html
Sent from the git mailing list archive at Nabble.com.
