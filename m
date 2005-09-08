From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] GIT Repository Annotation Convention
Date: Thu, 08 Sep 2005 11:00:33 -0700
Message-ID: <7vr7bzv3r2.fsf@assigned-by-dhcp.cox.net>
References: <87ll2aib73.fsf@gmail.com> <431DA8CD.9060009@gmail.com>
	<432060B8.6080408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 20:02:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDQhc-0005SG-4N
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 20:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVIHSAf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 14:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbVIHSAf
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 14:00:35 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:35313 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964913AbVIHSAf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2005 14:00:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050908180034.SCFQ3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Sep 2005 14:00:34 -0400
To: gitzilla@gmail.com
In-Reply-To: <432060B8.6080408@gmail.com> (A. Large Angry's message of "Thu,
	08 Sep 2005 12:03:04 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8206>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Naming and Directory Structure
> ------------------------------
> Annotations are named by appending ".txt" to the basename of the
> repository component it describes, and by appending ".dir" to each
> directory patch component leading to the repository component from
> $GIT_DIR, and by prepending "annotations/" to the annotation pathname.

I suspect you can do the same without .dir but only with .txt.
