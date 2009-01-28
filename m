From: Zabre <427@free.fr>
Subject: Re: (beginner) git rm
Date: Wed, 28 Jan 2009 13:05:43 -0800 (PST)
Message-ID: <1233176743011-2234918.post@n2.nabble.com>
References: <1233137498146-2231416.post@n2.nabble.com> <Pine.LNX.4.64.0901281133380.645@ds9.cixit.se> <1233140751523-2231622.post@n2.nabble.com> <49804385.908@dbservice.com> <1233144045221-2231849.post@n2.nabble.com> <49804D41.3010801@dbservice.com> <1233166992184-2233892.post@n2.nabble.com> <20090128201727.GD7503@atjola.homenet> <1233175322729-2234796.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 22:07:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSHcx-00026m-2H
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 22:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186AbZA1VFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 16:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbZA1VFp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 16:05:45 -0500
Received: from kuber.nabble.com ([216.139.236.158]:37605 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbZA1VFn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 16:05:43 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LSHbT-0002PI-0e
	for git@vger.kernel.org; Wed, 28 Jan 2009 13:05:43 -0800
In-Reply-To: <1233175322729-2234796.post@n2.nabble.com>
X-Nabble-From: 427@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107576>



Zabre wrote:
> 
> Oh just one (probably stupid) thing : <tree-ish> does represent a
> directory being the root of a tree of folders (which has been added to the
> index), does it?
> This is the way I understand it at the moment. It must be a convention I
> don't know just yet. (I need to investigate on this)
> 

Ok I found in the doc (in the "The Object Database" section) what trees are
about, seems a little bit more obscure, so I guess I'm not ready for this
right now. (I'm a beginner trying to use git for a simple regular workflow,
managing code and other documents)
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#the-object-database
I guess <tree-ish> refers to such an object, and you use it in order to
revert it from the Object Database.
I'll keep this idea in mind for when I'll try to restore data from tricky
last-chance "stores", there is a section about such things in the doc :
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#fixing-mistakes
I think that in a normal everyday use, the small index modification I can do
using the previous advices can do the job (or am I wrong?)
-- 
View this message in context: http://n2.nabble.com/%28beginner%29-git-rm-tp2231416p2234918.html
Sent from the git mailing list archive at Nabble.com.
