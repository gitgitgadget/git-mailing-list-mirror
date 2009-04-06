From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Initial Japanese gitk translation
Date: Mon, 6 Apr 2009 08:09:10 +0200
Message-ID: <20090406060910.GA8973@glandium.org>
References: <FD6CAD0757FA434C91E904C1F202CBA1@DELL300> <7vws9ymudz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: FORS Luis <l-fors@cerca-jp.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 08:09:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqi1q-00037u-Pb
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 08:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbZDFGIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 02:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbZDFGIW
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 02:08:22 -0400
Received: from vuizook.err.no ([85.19.221.46]:37299 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbZDFGIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 02:08:21 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Lqi07-00069l-W8; Mon, 06 Apr 2009 08:08:11 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Lqi18-0002PL-FU; Mon, 06 Apr 2009 08:09:10 +0200
Content-Disposition: inline
In-Reply-To: <7vws9ymudz.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115770>

On Sun, Apr 05, 2009 at 06:40:56PM -0700, Junio C Hamano wrote:
> > +msgid "Short SHA1 id %s is ambiguous"
> > +msgstr "%sを含むSHA1が複数存在する"
> 
> Good job!!
Should be します, though.
 
> > +msgid "The commits on branch %s aren't on any other branch.\nReally delete branch %s?"
> > +msgstr "ブランチ%sが一意リビジョンを含む。\nそれでも削除しますか？"
> 
> ブランチ%sには他ブランチにマージされていないコミットがあります。それでも・・・

Wouldn't it be better with brackets (「」) around %s ? 

Mike
