From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 1/3] stgit.el: Added undo command
Date: Thu, 30 Oct 2008 12:57:16 +0100
Message-ID: <20081030115716.GA19360@diana.vm.bytemark.co.uk>
References: <20081030095221.10290.58637.stgit@krank> <20081030095248.10290.81253.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Oct 30 12:58:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvWAn-0001nI-DJ
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 12:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbYJ3L5b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2008 07:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbYJ3L5b
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 07:57:31 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3538 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbYJ3L5a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 07:57:30 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KvW9M-00053p-00; Thu, 30 Oct 2008 11:57:16 +0000
Content-Disposition: inline
In-Reply-To: <20081030095248.10290.81253.stgit@krank>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99460>

On 2008-10-30 10:52:48 +0100, David K=E5gedal wrote:

> Bound it to the two standard bindings C-/ and C-_.

> +  (define-key stgit-mode-map [(control ?/)] 'stgit-undo)
> +  (define-key stgit-mode-map "\C-_" 'stgit-undo))

Hmm, why do you spell control in two different ways?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
