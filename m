From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] doc: remote author/documentation sections from more pages
Date: Mon, 27 Jan 2014 02:37:50 +0100
Message-ID: <52E5B86E.2060708@alum.mit.edu>
References: <1390779829-24168-1-git-send-email-mhagger@alum.mit.edu> <CAPig+cQ3w-VrjbgwgSMCRovR+P27f8GignyYG+bKic4RZEc5Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 27 02:38:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7b9G-0005c2-OC
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 02:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbaA0Bh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 20:37:59 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64866 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753121AbaA0Bh6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jan 2014 20:37:58 -0500
X-AuditID: 1207440d-b7f4c6d000004a16-12-52e5b87599ba
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.97.18966.578B5E25; Sun, 26 Jan 2014 20:37:57 -0500 (EST)
Received: from [192.168.69.148] (p57A2422E.dip0.t-ipconnect.de [87.162.66.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0R1bpY7024468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 26 Jan 2014 20:37:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CAPig+cQ3w-VrjbgwgSMCRovR+P27f8GignyYG+bKic4RZEc5Gw@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0gTcRzvd3fbbnNX59T281ktUijnIyKOCgl6rRAxDQIJ9dRrW26n7W6i
	vVAKsmlZJFgrXA/LfKCyylcmYUQWmfmISFOMFFJaqRFDsNadw8d/H76f1+/L94ejqmFJEG5k
	ecbC0iaNVIGpZHs3aK2tE0kxFR8jKdtgCUIVXh5EqZr6DpSqHGlHqLJqm5Ryfa4CVEm5C1CO
	rmsS6t2PIrBbrqvpOatrs4/IdNMzqbr+SbdU19e/UTff2yHR3R87pPvtDEvEU3x2ZdB8XrJR
	z0bHpfsYPM19SO4Yml/d/gApBMWoDeA4JLfBuQq9DcgFuBZ+GG2U2oACV5EDAH554sJEQkW+
	R+DQY1LEBLkFTre7MdGLkZtgb5FMHEtJLbxXeh4RcQCZDOsGxjCv3Be+uTm+gP1Fa5MTiPko
	OYfAyeHKBYMfmQCnW0pQb/ElAEtGh6QiIScPw9pXduB9qBqWFiWJY5SMhD+vjKFevA62uG6j
	V4GvfUWffYXMvkJ2B6C1IIw2Wc1aM200cUymlsukWZaxaLdGmY18FJNldQLvcYhW4GkI6QIk
	DjRK4vuO8SSVhM7jCsxdIBBHNAFE3MOJJNXqjJysAgPNGdIsVhPDdQGIoxp/gm0U5EQWXXCK
	seQsUsE4plET4VURCSpST/NMNsPkMpZFNgTHNZDIaRFCfS2Mnsk/bjTxyzSCy8VwRZA/x7BZ
	jIW28oY08b5pnHBgkVIKvWtEO8Hl0mZh6rW+BVr8UdPsPFBhbA7LBKmJ9GZBRIoig5Vdqlj8
	k1NALWzsR8SIUUrhxy4lTQkliFBS0ykux/H0MhVUCLb3OgqbSh2h547c8FmVGkjJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241127>

On 01/27/2014 01:15 AM, Eric Sunshine wrote:
> On Sun, Jan 26, 2014 at 6:43 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Subject: [PATCH] doc: remote author/documentation sections from more pages
> 
> s/remote/remove/

Gaah!  Git is a virus that invades your muscle memory and prevents you
from typing words that are similar to git subcommands.

Thanks for noticing.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
