From: takeshin <admirau@gmail.com>
Subject: update @version in file
Date: Wed, 13 May 2009 01:59:50 -0700 (PDT)
Message-ID: <1242205190383-2879913.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:00:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4AJn-0004kD-Rv
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 11:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758749AbZEMI7v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 04:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759202AbZEMI7u
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 04:59:50 -0400
Received: from kuber.nabble.com ([216.139.236.158]:60402 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758993AbZEMI7t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 04:59:49 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1M4AJa-0005OP-CX
	for git@vger.kernel.org; Wed, 13 May 2009 01:59:50 -0700
X-Nabble-From: admirau@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119008>


Hi,

I have following PHPDoc code in files of my repository:

/**
 * Class description
 * @version 1.2
 */
 class Name=E2=80=A6

Is there a chance that git could increment this @version automatically
on each commit or stamp the file somehow?

I'm using git on Windows.

--=20
regards
takeshin


--=20
View this message in context: http://n2.nabble.com/update-%40version-in=
-file-tp2879913p2879913.html
Sent from the git mailing list archive at Nabble.com.
