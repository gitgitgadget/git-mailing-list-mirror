From: nguyenhu@minatec.inpg.fr
Subject: Re: [RFC] Possibility to have a per-user config directory
Date: Wed, 30 May 2012 16:44:01 +0200
Message-ID: <20120530164401.Horde.D-Vga3wdC4BPxjIxzpiUbLA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr
To: victor.engmark@gmail.com
X-From: git-owner@vger.kernel.org Wed May 30 16:44:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZk8O-0004J5-UN
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 16:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066Ab2E3OoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 10:44:07 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:37453 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754310Ab2E3OoF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 10:44:05 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 401BF1A024F;
	Wed, 30 May 2012 16:44:02 +0200 (CEST)
Received: from wifi-028109.grenet.fr (wifi-028109.grenet.fr
 [130.190.28.109]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Wed, 30 May 2012 16:44:01 +0200
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198811>

Victor Engmark <victor.engmark@gmail.com> wrote:
> Minor suggestion: Write to $XDG_CONFIG_HOME/git/config if:
> - $XDG_CONFIG_HOME/git exists (and therefore is planned for use even
> if there is no config file within)
> - [etc. as before]

We agree. We will do it in the patch for writing.

Lucien KONG,
Valentin DUPERRAY,
Huynh Khoi Nguyen NGUYEN,
Thomas NGUY,
Franck JONAS

Grenoble INP ENSIMAG
