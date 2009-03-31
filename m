From: byrnejb <byrnejb@harte-lyne.ca>
Subject: Re: git doc build failure on OS X 10.5.6 (Leopard) during xmlto
 phase
Date: Tue, 31 Mar 2009 13:56:31 -0700 (PDT)
Message-ID: <1238532991146-2565413.post@n2.nabble.com>
References: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com> <76718490903110812t5e1723ebi28a84da680422d8a@mail.gmail.com> <76718490903110839m17041c7bxd7912eb09496c81a@mail.gmail.com> <76718490903110849x2ef48a89j3f17706390991eda@mail.gmail.com> <49B7E670.7060606@drmicha.warpmail.net> <gp95vf$gp1$1@ger.gmane.org> <49B8EF3E.2070208@drmicha.warpmail.net> <20090312170931.GB19175@inocybe.teonanacatl.org> <49BA356D.8050007@drmicha.warpmail.net> <76718490903130918r733e3ef4meae49311883969b5@mail.gmail.com> <1238530620384-2565224.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 22:58:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lol2l-0003c1-Vt
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 22:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081AbZCaU4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 16:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755855AbZCaU4e
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 16:56:34 -0400
Received: from kuber.nabble.com ([216.139.236.158]:33105 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759017AbZCaU4d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 16:56:33 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1Lol0Z-0006ZP-77
	for git@vger.kernel.org; Tue, 31 Mar 2009 13:56:31 -0700
In-Reply-To: <1238530620384-2565224.post@n2.nabble.com>
X-Nabble-From: byrnejb@harte-lyne.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115317>




Is there a way to simply skip the documentation part of the build?


$ rpmbuild -bb --without docs git.spec # this gets me the application at least.

Is there a fix or workaroung to get past the asciidoc error?
-- 
View this message in context: http://n2.nabble.com/git-doc-build-failure-on-OS-X-10.5.6-%28Leopard%29-during-xmlto-phase-tp2461534p2565413.html
Sent from the git mailing list archive at Nabble.com.
