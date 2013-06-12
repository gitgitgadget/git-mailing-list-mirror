From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #04; Tue, 11)
Date: Wed, 12 Jun 2013 13:56:20 +0000 (UTC)
Message-ID: <loom.20130612T154959-145@post.gmane.org>
References: <7vwqq05laf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 15:56:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmlXa-0008JU-1U
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 15:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032Ab3FLN4k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 09:56:40 -0400
Received: from plane.gmane.org ([80.91.229.3]:58246 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3FLN4i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 09:56:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UmlXQ-0008CK-8b
	for git@vger.kernel.org; Wed, 12 Jun 2013 15:56:36 +0200
Received: from epo198.neoplus.adsl.tpnet.pl ([83.20.56.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 15:56:36 +0200
Received: from jnareb by epo198.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 15:56:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.20.56.198 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.22 (KHTML, like Gecko) Ubuntu Chromium/25.0.1364.160 Chrome/25.0.1364.160 Safari/537.22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227615>

Junio C Hamano <gitster <at> pobox.com> writes:

> * rr/remove-contrib-some (2013-06-02) 1 commit
>   (merged to 'next' on 2013-06-05 at fc15705)
>  + contrib: remove continuous/ and patches/
>=20
>  Remove stale contrib/ material.
>=20
>  Will merge to 'master'.

What about contrib/blameview by Aneesh Kumar K.V <aneesh.kumar@gmail.co=
m>
and Jeff King <peff@peff.net>?

It is also 6 years old, uses GTK 2.x (via Gtk2 Perl bindings), "git gui=
=20
blame" also uses incremental mode moreover comparing blame with and wit=
hout=20
code movement detection.

Though this was intended more as a demo of using incremental blame... (=
c.f.=20
contrib/examples).

--=20
Jakub Nar=C4=99bski
(via GMane)
