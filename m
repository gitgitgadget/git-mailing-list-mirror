From: Olivier Galibert <galibert@pobox.com>
Subject: path-restricted gitk with tags showing up?
Date: Tue, 1 Aug 2006 19:42:10 +0200
Message-ID: <20060801174210.GA81699@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Aug 01 19:42:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7yGB-00070e-NS
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 19:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWHARmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 13:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWHARmQ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 13:42:16 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:3592 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751732AbWHARmN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 13:42:13 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 6F887A37D6; Tue,  1 Aug 2006 19:42:10 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24606>

I'd like to do a (f.i) gitk include/sound/asound.h but still see the
commits which are in the DAG delimited by the alsa commits and have
tags attached.  The aim is to know what changes where in what released
kernel version.  Is there a way to do that?

  OG.
