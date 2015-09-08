From: "rubenkram@spacetrace.org" <rubenkram@spacetrace.org>
Subject: [Feature request] help.autocorrect suggestion with Y/N
Date: Tue, 8 Sep 2015 10:11:20 +0200
Message-ID: <55EE9828.106@spacetrace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 08 10:18:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZE6g-0003e0-UQ
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 10:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbbIHIST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 04:18:19 -0400
Received: from www1.eclabs.de ([213.239.220.106]:45861 "EHLO www1.eclabs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbbIHISR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 04:18:17 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Sep 2015 04:18:17 EDT
Received: from [10.116.141.244] (unknown [95.211.90.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by www1.eclabs.de (Postfix) with ESMTPSA id 35DF11E100EF
	for <git@vger.kernel.org>; Tue,  8 Sep 2015 10:11:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277495>

When you type

 git clone https://repo.git

now you get

 git: 'glone' is not a git command. See 'git --help'.

 Did you mean this?
	clone

It would be handsome if you could say "Yes" to this question so you
don't have to manually correct your last command like:

 Did you mean this?
        clone
 [Y/n]
