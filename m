From: jhapk <pradeep.kumar.jha@gmail.com>
Subject: Re: Deleting remote branches
Date: Thu, 25 Mar 2010 22:09:03 -0800 (PST)
Message-ID: <1269583743012-4802313.post@n2.nabble.com>
References: <1269582415273-4802262.post@n2.nabble.com> <f3271551003252300u387f6081seaa03d4eb7194486@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 07:09:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv2jG-0000gz-U7
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 07:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170Ab0CZGJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 02:09:05 -0400
Received: from kuber.nabble.com ([216.139.236.158]:44032 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab0CZGJD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 02:09:03 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <pradeep.kumar.jha@gmail.com>)
	id 1Nv2j9-0002RV-0a
	for git@vger.kernel.org; Thu, 25 Mar 2010 23:09:03 -0700
In-Reply-To: <f3271551003252300u387f6081seaa03d4eb7194486@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143211>


Hi,

I have tried that and I get the following message

[pradeep@scaramanga cffc]$ git push origin:test
error: dst refspec test does not match any existing ref on the remote and
does not start with refs/.
fatal: The remote end hung up unexpectedly
error: failed to push to '/nfs/carv/d1/people/pradeep/Repositories/CFFC.git'

don't know what this means.
-- 
View this message in context: http://n2.nabble.com/Deleting-remote-branches-tp4802262p4802313.html
Sent from the git mailing list archive at Nabble.com.
