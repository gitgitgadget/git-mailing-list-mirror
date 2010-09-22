From: FernandoBasso <FernandoBasso.br@gmail.com>
Subject: Re: Really beginner on Version Control
Date: Wed, 22 Sep 2010 04:49:49 -0700 (PDT)
Message-ID: <1285156189754-5558706.post@n2.nabble.com>
References: <1285080133451-5555023.post@n2.nabble.com> <m3mxrak937.fsf@localhost.localdomain> <1285114417273-5557145.post@n2.nabble.com> <1AF8A1BC-1E52-4385-A0FC-16A04B4724FF@kellerfarm.com> <1285155943433-5558696.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 13:49:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyNpk-0006oV-3D
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 13:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758Ab0IVLtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 07:49:50 -0400
Received: from kuber.nabble.com ([216.139.236.158]:50797 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab0IVLtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 07:49:50 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <FernandoBasso.br@gmail.com>)
	id 1OyNpd-00070z-Oc
	for git@vger.kernel.org; Wed, 22 Sep 2010 04:49:49 -0700
In-Reply-To: <1285155943433-5558696.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156800>


On 09/22/2010 04:35 AM, Thomas Hochstein [via git] wrote:
>
> You have changed "hello" to world in your testing branch. When you
> merge your testing branch back to your master branch, git will apply
> all changes you made in testing to master. That's not a problem in
> that case, as master was not changed since testing was branched from
> it.
>

Okay. So, If I have not changed master since I last edited testing, I can
merge testing into master without problem.

I merge testing into master (without problems) and I change master and merge
testing into master again (without any further modification). Now, git
thinks that the changes I've just made in master are more important than the
old changes in testing ?

-- 
View this message in context: http://git.661346.n2.nabble.com/Really-beginner-on-Version-Control-tp5555023p5558706.html
Sent from the git mailing list archive at Nabble.com.
