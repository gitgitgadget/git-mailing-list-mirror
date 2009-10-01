From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Trying to split repository
Date: Thu, 1 Oct 2009 18:49:56 +0200
Message-ID: <427FD5A1-A416-424C-9F6F-35AE9E6F9E9B@dbservice.com>
References: <20091001160335.GA26068@raven.wolf.lan>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Thu Oct 01 18:50:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtOrQ-0004Tb-3Y
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 18:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455AbZJAQuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 12:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755356AbZJAQuX
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 12:50:23 -0400
Received: from office.neopsis.com ([78.46.209.98]:57355 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbZJAQuW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 12:50:22 -0400
Received: from [10.3.112.169] ([147.88.200.112])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com;
	Thu, 1 Oct 2009 18:50:21 +0200
In-Reply-To: <20091001160335.GA26068@raven.wolf.lan>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129401>


On Oct 1, 2009, at 6:03 PM, Josef Wolf wrote:

> Hello,
>
> One of my repositories has grown a subdirectory that I'd like to  
> split off,
> so other can use it as a subproject. With the help of google, I  
> found this
> solution:

Take a look at git-subtree (http://github.com/apenwarr/git-subtree).

tom
