From: Prasad <maninc@gmail.com>
Subject: error: http-push died with strange error
Date: Fri, 13 Feb 2009 04:39:12 -0800 (PST)
Message-ID: <1234528752345-2320994.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 13:42:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXxLV-0005xo-Q5
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 13:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbZBMMjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 07:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbZBMMjO
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 07:39:14 -0500
Received: from kuber.nabble.com ([216.139.236.158]:33352 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbZBMMjO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 07:39:14 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LXxK4-0003jY-BM
	for git@vger.kernel.org; Fri, 13 Feb 2009 04:39:12 -0800
X-Nabble-From: maninc@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109744>


Hi,

I am facing this error below when i try to push my changes to server.

$ git push
Fetching remote heads...
 refs/
 refs/heads/
 refs/tags/
updating 'refs/heads/master'
 from 29302b418fb879fee5f383652ccbf4bb7a5adfaf
 to   33254d9d06e86afee0ff17e012882353be828040
   sending 11 objects
   done
Updating remote server info
error: http-push died with strange error
error: failed to push some refs to 'https://url.com'

What might be the possible issue with http-push.

Thanks in advance

Mani
-- 
View this message in context: http://n2.nabble.com/error%3A-http-push-died-with-strange-error-tp2320994p2320994.html
Sent from the git mailing list archive at Nabble.com.
