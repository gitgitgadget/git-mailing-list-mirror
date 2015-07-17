From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] userdiff: add support for Fountain documents
Date: Fri, 17 Jul 2015 15:03:46 +0200
Organization: gmx
Message-ID: <e2ddebd5451a9331e03b24c719f68530@www.dscho.org>
References: <1437134351-15392-1-git-send-email-zoe@bytenoise.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Zoe=CC=88_Blade?= <zoe@bytenoise.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 17 15:03:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG5Ix-000242-5w
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 15:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756233AbbGQNDu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2015 09:03:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:58158 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754933AbbGQNDt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 09:03:49 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LvlTo-1YsiS73FK0-017ULs; Fri, 17 Jul 2015 15:03:47
 +0200
In-Reply-To: <1437134351-15392-1-git-send-email-zoe@bytenoise.co.uk>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:0ZF4OF3g1e5WMS4QLPhFiRr3TpGMnj8H08tE6NtWL1p0hfmu58n
 K2GMuHFw4ESpqXy+FmBM0YirYAMwJORhyOc7gcFJ5+IXQdBEbthrBcwV8ltCB8iGXdahAIg
 4m68wDDZceuspVAdK5pc+a1215KjJ//8qOfOrudiXu6Wjir2/Km89JHAajhKvshMHthZbyM
 YGYjXaKAuMg2MEzX1qJdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qDPkXeUj7bE=:Qb9dH1CTtSc41aEY7iHVqu
 RPgBANkcPfT71OPL71pAYlm2haPsIJF9c+9bRDlcneM5WjXfAiK7GOb/9JxPAM5s1g3ky6tGo
 1rQrN/iDy4v+W2Bx5QRgry78ns5YCpP6LDBOrMbgkd07XdjwPAis/7dI6wxABEFPJG8j4oSew
 SBkOpOV5s1nd/Zv/+kqdi9WReO/7E+HpqCNKhxcOfVMOC8d0La/NoeB12O5l2iuxqw3Mj6Pqj
 4Fg19ydSbsbAIFXhD4Ipqtjhxpx6rmn8PrnupRQLHa/35fxzu2GL3hXzz4UxNfcec69XgnKX0
 E61N/tEIryir3Kyj61EOHrt3UXphCFHnlbX9LWlSkc5OAyjOIHz59sVPaEKa4H4ZZaSS1OXvf
 XLKk7SVQKIWfxK5YjBmd+vY7BV/peLIh5kPjUlWa8lwlrjNJ6q1MtYo2bsCAPC4JWvXEIC5FD
 /uawMgylLnkTcJrsB5reToMEIRXciyrC/TFfUCGoX9tun0LaK4ny2Pj2k+v6oOIHJlVMlzPC0
 WHcCopxXE5/5SRZIwHR2ituP4wHj3iRqx518ghpsA7Q5HJPpmnlV1OsvAjtjs/I+5BNDOJvYy
 LxnziyUhkqiJpklYdENdVoe6fFNlTXItCqVOI0owpYb6Rv5H1768Lh+K2END2BZ8ZkzgmBG5S
 cu9k+jH52xgpzpu+D8k+pb5frUyBnYt4AOJ9TPCPvJwA5ajfVGTkpKUnAwrp2aycGjVg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274069>

Hi Zoe=CC=88,

On 2015-07-17 13:59, Zoe=CC=88 Blade wrote:
> Add support for Fountain, a plain text screenplay format.  In the
> structure of a screenplay, scenes are roughly analogous to functions,
> in the sense that it makes your job slightly easier if you can see
> which ones were changed in a given range of patches.

Interesting!

Maybe you want to add a paragraph explaining a bit more about Fountain,=
 or at least link to http://fountain.io/?

In any case, you will need to sign off on your patch:

    https://github.com/git/git/blob/v2.4.6/Documentation/SubmittingPatc=
hes#L234-L286

Ciao,
Johannes
