From: goooguo <erwangg@fortemedia.com.cn>
Subject: question: how to ignore extral CR when diff dos format files with
 'color=auto'
Date: Mon, 25 Aug 2008 22:32:23 -0700 (PDT)
Message-ID: <1219728743111-783231.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 07:33:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXrBJ-0004rw-QG
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 07:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbYHZFcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 01:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbYHZFcY
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 01:32:24 -0400
Received: from kuber.nabble.com ([216.139.236.158]:60663 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbYHZFcX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 01:32:23 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1KXrAF-0002AP-3l
	for git@vger.kernel.org; Mon, 25 Aug 2008 22:32:23 -0700
X-Nabble-From: erwangg@fortemedia.com.cn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93712>


hi,

git-diff prints "^M" at each end of line for dos format files when
'color=auto'.

it's annoying!

I want to know if I can configure git to make git-diff ignore '^M', and I
don't want to change file format to unix.

thank you.
-- 
View this message in context: http://n2.nabble.com/question%3A-how-to-ignore-extral-CR-when-diff-dos-format-files-with-%27color%3Dauto%27-tp783231p783231.html
Sent from the git mailing list archive at Nabble.com.
