From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: STGIT: stg import -s with a patch option
Date: Wed, 25 Feb 2009 10:58:27 +0100
Message-ID: <20090225095827.GA16706@diana.vm.bytemark.co.uk>
References: <9e4733910902241628u5a2db3bhca37e9214668eb02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 11:00:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGYq-0003uO-8B
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 11:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761554AbZBYJ6e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 04:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761401AbZBYJ6e
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:58:34 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:41403 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760730AbZBYJ6c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 04:58:32 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LcGX5-0004zK-00; Wed, 25 Feb 2009 09:58:27 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910902241628u5a2db3bhca37e9214668eb02@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111433>

On 2009-02-24 19:28:13 -0500, Jon Smirl wrote:

> stg doesn't know how to pick up the -p0 and then run patch with -p0.

I added this to the issue tracker: https://gna.org/task/index.php?6498

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
